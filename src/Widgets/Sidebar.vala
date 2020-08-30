public class RConnMan.Sidebar : Gtk.Frame {
    public MainWindow window { get; construct; }
    public Granite.Widgets.SourceList source_list;
    
    public Sidebar (MainWindow window) {
        Object (window : window);
    }
    
    construct {
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

        
        source_list = new Granite.Widgets.SourceList ();
        treeview_guiders ();
        
       // This will add the main categories (including their children) to the source list. After
        // having being added to be widget, any other item added to any of these items
        // (or any other child item in a deeper level) will be automatically added too.
        // There's no need to deal with the source list widget directly.

        var root = source_list.root;

        root.add (hosts_category);  
        root.add (accounts_category);
        
        add (source_list);
        
        // If gsettings enable-tree-line change, then we want to update the app.
        Application.settings.changed["enable-tree-lines"].connect (() => {
            treeview_guiders ();
        });
    }
    
    public void treeview_guiders () {
        if (Application.settings.get_boolean ("enable-tree-lines")) {
            ((Gtk.TreeView) source_list.get_child ()).enable_tree_lines = true;
        }
        else {
            ((Gtk.TreeView) source_list.get_child ()).enable_tree_lines = false;
        }
    }
}
