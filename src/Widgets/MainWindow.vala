public class RConnMan.MainWindow : Gtk.ApplicationWindow {

    public WelcomeView welcome;
    
    public MainWindow (Gtk.Application app) {
        Object (
            application: app,
            title: "Remote Connection Manager"
        );
    }
    
    construct {
        welcome = new WelcomeView();
    
        window_position = Gtk.WindowPosition.CENTER;
        
        int window_x, window_y;
        int window_h, window_w;
        
        Application.settings.get ("window-position", "(ii)", out window_x, out window_y);
        Application.settings.get ("window-size", "(ii)", out window_w, out window_h);
        
        move (window_x, window_y);
        resize (window_w, window_h);
        
        if (Application.settings.get_boolean ("window-maximized")) {
            maximize ();
        }
        
        set_titlebar (new HeaderBar ());
        
        var context = get_style_context ();
        context.add_class ("rounded");
        context.add_class ("flat");

        var paned = new Gtk.Paned (Gtk.Orientation.HORIZONTAL);
        
        int paned_position = Application.settings.get_int ("panel-size");
        

        var gtk_settings = Gtk.Settings.get_default ();

        Application.settings.bind ("dark-theme", gtk_settings, "gtk-application-prefer-dark-theme", GLib.SettingsBindFlags.DEFAULT);

        var left_label = new Gtk.Label ("Left");
        
        paned.pack1 (left_label, false, false);
        paned.pack2 (welcome, true, false);
        paned.set_position(paned_position);
        
        add (paned);
        
        /* Size of panel */
        paned.size_allocate.connect(() => {
            if (paned.get_position () != Application.settings.get_int ("panel-size")) {
                Application.settings.set_int ("panel-size", paned.get_position());
            }
        });

    }
    
    public override bool delete_event (Gdk.EventAny event) {
    
        if (is_maximized) {
            Application.settings.set_boolean ("window-maximized", true);
        } else {
            Application.settings.set_boolean ("window-maximized", false);
            
            int width, height, x ,y;
            
            get_size (out width, out height);
            Application.settings.set ("window-size", "(ii)", width, height);
            
            get_position (out x, out y);
            Application.settings.set ("window-position", "(ii)", x, y);
        }


        return false;
    }
      
}
