public class MainWindow : Gtk.Window {

    private uint configure_id;
    
    public MainWindow (Gtk.Application application) {
        Object (
            application: application,
            title: "Remote Connection Manager",
            window_position: Gtk.WindowPosition.CENTER
            //default_width: 800,
            //default_height: 600
        );
    }
    
    construct {
        int window_x, window_y;
        var rect = Gtk.Allocation ();
        
        Application.settings.get ("window-position", "(ii)", out window_x, out window_y);
        Application.settings.get ("window-size", "(ii)", out rect.width, out rect.height);

        
        if (window_x != -1 || window_y != -1) {
            move (window_x, window_y);
        }
        
        set_allocation (rect);
        
        if (Application.settings.get_boolean ("window-maximized")) {
            maximize ();
        }
        
        var switch = new Gtk.Switch ();

        add (switch);
        
        //var settings = new GLib.Settings ("com.github.rippieuk.rconnman");
        Application.settings.bind ("useless-setting", switch, "active", GLib.SettingsBindFlags.DEFAULT);
    }
    
    public override bool configure_event (Gdk.EventConfigure event) {
    if (configure_id != 0) {
        GLib.Source.remove (configure_id);
    }

    configure_id = Timeout.add (100, () => {
        configure_id = 0;

        if (is_maximized) {
            Application.settings.set_boolean ("window-maximized", true);
        } else {
            Application.settings.set_boolean ("window-maximized", false);

            Gdk.Rectangle rect;
            get_allocation (out rect);
            Application.settings.set ("window-size", "(ii)", rect.width, rect.height);

            int root_x, root_y;
            get_position (out root_x, out root_y);
            Application.settings.set ("window-position", "(ii)", root_x, root_y);
        }

        return false;
    });

    return base.configure_event (event);
}
}
