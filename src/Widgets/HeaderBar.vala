public class RConnMan.HeaderBar : Gtk.HeaderBar {
    
    construct {   
        var header_context = get_style_context ();
        header_context.add_class ("titlebar");
        header_context.add_class ("default-decoration");
        
        has_subtitle = false;
        show_close_button = true;
    
        get_style_context ().add_class ("default-decoration");

        var preferences_menuitem = new Gtk.MenuItem.with_label ("Preferences");
        var about_menuitem = new Gtk.MenuItem.with_label ("About");

        var menu = new Gtk.Menu ();
        menu.append (preferences_menuitem);
        menu.append (about_menuitem);
        menu.show_all ();

        var settings_button = new Gtk.MenuButton ();
        settings_button.image = new Gtk.Image.from_icon_name ("open-menu", Gtk.IconSize.LARGE_TOOLBAR);
        settings_button.has_tooltip = true;
        settings_button.popup = menu;
        settings_button.valign = Gtk.Align.CENTER;

        preferences_menuitem.activate.connect (() => {
            new Preferences (get_toplevel () as Gtk.Window).show_all (); 
         });
         
         about_menuitem.activate.connect (() => {
            new AboutDialog (get_toplevel () as Gtk.Window).show_all (); 
         });
        
        pack_end (settings_button);
    }
}
