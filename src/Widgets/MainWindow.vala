public class MainWindow : Gtk.ApplicationWindow {

    private uint configure_id;
    
    public MainWindow (Gtk.Application app) {
        Object (
            application: app
        );
    }
    
    construct {
    
        title = "Remote Connection Manager";
        window_position = Gtk.WindowPosition.CENTER;
        
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
        
        var my_switch = new Gtk.Switch ();
        Application.settings.bind ("useless-setting", my_switch, "active", GLib.SettingsBindFlags.DEFAULT);
        
        var use_dark_theme = new Gtk.Switch ();
        Application.settings.bind ("dark-theme", use_dark_theme, "active", GLib.SettingsBindFlags.DEFAULT);
        
        var main_grid = new Gtk.Grid ();
        
        main_grid.attach (new Gtk.Label ("Useless Setting"), 0, 0, 1, 1);
        main_grid.attach (my_switch, 1, 0, 1, 1);
        
        main_grid.attach (new Gtk.Label ("Prefer Dark Theme"), 0, 1, 1, 1);
        main_grid.attach (use_dark_theme, 1, 1, 1, 1);
        
        add (main_grid);
        
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
