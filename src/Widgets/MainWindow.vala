public class RConnMan.MainWindow : Gtk.ApplicationWindow {

    public WelcomeView welcome;
    
    public MainWindow (Gtk.Application app) {
        Object (
            application: app,
            title: "Remote Connection Manager"
        );
    }
    
    construct {
        Gtk.IconTheme.get_default ().add_resource_path ("/com/github/rippieuk/rconnman");
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
        
        /* SourceList Example */
        var hosts_category = new Granite.Widgets.SourceList.ExpandableItem ("Hosts");
        var accounts_category = new Granite.Widgets.SourceList.ExpandableItem ("Accounts");
        
        var win_host_item = new Granite.Widgets.SourceList.ExpandableItem ("Windows");
        win_host_item.icon = new GLib.ThemedIcon ("rdp_protocol_icon");
        hosts_category.add (win_host_item);
        
        var host_item = new Granite.Widgets.SourceList.Item ("Host1");
        host_item.icon = new ThemedIcon ("rdp_protocol_icon");
        
        var host_item2 = new Granite.Widgets.SourceList.Item ("Host2");
        host_item2.icon = new ThemedIcon ("rdp_protocol_icon");
        
        // "Libraries" will be the parent category of "Music"
        win_host_item.add (host_item);
        win_host_item.add (host_item2);
        
        // We plan to add sub-items to the store, so let's use an expandable item
        var win_account_item = new Granite.Widgets.SourceList.ExpandableItem ("Windows");
        win_account_item.icon = new GLib.ThemedIcon ("system-users");
        accounts_category.add (win_account_item);

        var win_account_rdp_account1_item = new Granite.Widgets.SourceList.Item ("Win Account 1");
        win_account_rdp_account1_item.icon = new GLib.ThemedIcon ("avatar-default");
        
        var win_account_rdp_account2_item = new Granite.Widgets.SourceList.Item ("Win Account 2");
        win_account_rdp_account2_item.icon = new GLib.ThemedIcon ("ssh_protocol_icon");
        
        win_account_item.add (win_account_rdp_account1_item);
        win_account_item.add (win_account_rdp_account2_item);

        
        var source_list = new Granite.Widgets.SourceList ();
        if (Application.settings.get_boolean ("enable-tree-lines")) {
            ((Gtk.TreeView) source_list.get_child ()).enable_tree_lines = true;
        }
        else {
            ((Gtk.TreeView) source_list.get_child ()).enable_tree_lines = false;
        }
        
        
        // This will add the main categories (including their children) to the source list. After
        // having being added to be widget, any other item added to any of these items
        // (or any other child item in a deeper level) will be automatically added too.
        // There's no need to deal with the source list widget directly.

        var root = source_list.root;

        root.add (hosts_category);  
        root.add (accounts_category);
        
        paned.pack1 (source_list, false, false);
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
