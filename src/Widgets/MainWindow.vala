public class RConnMan.MainWindow : Gtk.ApplicationWindow {

    public WelcomeView welcome_view;
    public Sidebar sidebar;
    public RConnMan.MainView main_view;
    public Gtk.Stack content_stack;
    
    public MainWindow (Gtk.Application app) {
        Object (
            application: app,
            title: "Remote Connection Manager"
        );
    }
    
    construct {
        int window_x, window_y;
        int window_h, window_w;

        var gtk_settings = Gtk.Settings.get_default ();
        Application.settings.bind ("dark-theme", gtk_settings, "gtk-application-prefer-dark-theme", GLib.SettingsBindFlags.DEFAULT);
        Application.settings.get ("window-position", "(ii)", out window_x, out window_y);
        Application.settings.get ("window-size", "(ii)", out window_w, out window_h);
    
        // window_position = Gtk.WindowPosition.CENTER; // Not needed i think??
        
        move (window_x, window_y);
        resize (window_w, window_h);
        
        if (Application.settings.get_boolean ("window-maximized")) {
            maximize ();
        }

        /*
         * Styling
        */
        Gtk.IconTheme.get_default ().add_resource_path ("/com/github/rippieuk/rconnman");
        
        var context = get_style_context ();
        context.add_class ("rounded");
        context.add_class ("flat");

        /*
         * The actual program code
        */

        set_titlebar (new HeaderBar ());        

        welcome_view = new WelcomeView();
        var view_grid = new Gtk.Grid () {
            orientation = Gtk.Orientation.VERTICAL
        };

        //var notebook = new RConnMan.Notebook ();
        //notebook.show ();

        main_view = new MainView ();
        view_grid.add (main_view);

        content_stack = new Gtk.Stack () {
            expand = true,
            width_request = 200
        };

        content_stack.add (welcome_view);
        content_stack.add (view_grid);

        var paned = new Gtk.Paned (Gtk.Orientation.HORIZONTAL);
        int paned_position = Application.settings.get_int ("panel-size");
        
        sidebar = new Sidebar (this);
        
        paned.pack1 (sidebar, false, false);
        paned.pack2 (content_stack, true, false);
        paned.set_position(paned_position);
        
        add (paned);
        
        /* Size of panel */
        paned.size_allocate.connect(() => {
            if (paned.get_position () != Application.settings.get_int ("panel-size")) {
                Application.settings.set_int ("panel-size", paned.get_position());
            }
        });

        sidebar.host_item.activated.connect (() => {
            content_stack.visible_child = welcome_view;
            //toolbar.title = app.app_cmd_name;
            //toolbar.document_available (false);
            //set_widgets_sensitive (false);
        });

        //  main_view.tab_added.connect (() => {
        //      content_stack.visible_child = view_grid;
        //      //toolbar.document_available (true);
        //      //set_widgets_sensitive (true);
        //  });

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
