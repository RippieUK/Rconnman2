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
        var label = new Gtk.Label ("Remote Connection Manager");
        
        add (label);
        
    }
}
