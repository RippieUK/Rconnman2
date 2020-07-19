public class MainWindow : Gtk.Window {
    public MainWindow (Gtk.Application application) {
        Object (
            application: application,
            title: "Remote Connection Manager",
            window_position: Gtk.WindowPosition.CENTER,
            default_width: 800,
            default_height: 600
        );
    }
    
    construct {
        var switch = new Gtk.Switch ();
        //var label = new Gtk.Label ("Remote Connection Manager");
        
        //add (label);
        add (switch);
        
        //var settings = new GLib.Settings ("com.github.rippieuk.rconnman");
        settings.bind ("useless-setting", switch, "active", GLib.SettingsBindFlags.DEFAULT);
    }
}
