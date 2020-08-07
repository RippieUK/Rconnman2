public class RConnMan.HeaderBar : Gtk.HeaderBar {

    public MainWindow window { get; construct; }
    
    public HeaderBar (MainWindow window) {
                Object (
                    window: window,
                    has_subtitle: false,
                    show_close_button: true
                );
    }
    
    construct {
        get_style_context ().add_class ("default-decoration");
        
        var settings_button = new Gtk.Button.from_icon_name ("open-menu", Gtk.IconSize.SMALL_TOOLBAR);
        settings_button.clicked.connect (() => {
           new Preferences (get_toplevel () as Gtk.Window).show_all (); 
        });

        // var preferences_menuitem = new Gtk.MenuItem.with_label ("Preferences");
        // preferences_menuitem.action_name = MainWindow.ACTION_PREFIX + MainWindow.ACTION_PREFERENCES;
        // var menu = new Gtk.Menu ();
        // menu.append (preferences_menuitem);
        // menu.show_all ();

        // Gtk.MenuButton settings_button = new Gtk.MenuButton ();
        // settings_button.image = new Gtk.Image.from_icon_name ("open-menu-symbolic", Gtk.IconSize.SMALL_TOOLBAR);
        // settings_button.popup = menu;
        // settings_button.tooltip_text = "Menu";
        // settings_button.valign = Gtk.Align.CENTER;
        
        pack_end (settings_button);
    }
}
