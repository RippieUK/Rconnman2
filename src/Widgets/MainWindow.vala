public class RConnMan.MainWindow : Gtk.ApplicationWindow {

    public HeaderBar headerbar;
    
    public MainWindow (Gtk.Application app) {
        Object (
            application: app,
            title: "Remote Connection Manager"
        );
    }
    
    construct {
    
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
        
        headerbar = new HeaderBar (this);
        var header_context = headerbar.get_style_context ();
        header_context.add_class ("titlebar");
        header_context.add_class ("default-decoration");
        //header_context.add_class (Gtk.STYLE_CLASS_FLAT);
        
        var my_switch = new Gtk.Switch ();
        Application.settings.bind ("useless-setting", my_switch, "active", GLib.SettingsBindFlags.DEFAULT);
        
        var gtk_settings = Gtk.Settings.get_default ();
        
        var use_dark_theme = new Gtk.Switch ();
        Application.settings.bind ("dark-theme", use_dark_theme, "active", GLib.SettingsBindFlags.DEFAULT);
        Application.settings.bind ("dark-theme", gtk_settings, "gtk-application-prefer-dark-theme", GLib.SettingsBindFlags.DEFAULT);
        
        var my_entry = new Gtk.Entry ();
        my_entry.max_length = 5;
        my_entry.max_width_chars = 5;
        my_entry.width_chars = 5;
        
        var main_grid = new Gtk.Grid ();
        
        main_grid.attach (new Gtk.Label ("Useless Setting"), 0, 0, 1, 1);
        main_grid.attach (my_switch, 1, 0, 1, 1);
        
        main_grid.attach (new Gtk.Label ("Prefer Dark Theme"), 0, 1, 1, 1);
        main_grid.attach (use_dark_theme, 1, 1, 1, 1);
        
        main_grid.attach (new Gtk.Label ("Entry box"), 0, 2, 1, 1);
        main_grid.attach (my_entry, 1, 2, 1, 1);
        
        get_style_context ().add_class ("rounded");
        
        add (main_grid);
        
        set_titlebar (headerbar);
        
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
