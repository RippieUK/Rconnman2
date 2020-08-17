public class RConnMan.Application : Gtk.Application {
    
    public static GLib.Settings settings;
    static construct {
        settings = new GLib.Settings ("com.github.rippieuk.rconnman");
    }
    
    public const string APP_VERSION = "0.1";
    
    public Application () {
        Object (
            application_id: "com.github.rippieuk.rconnman",
            flags: ApplicationFlags.FLAGS_NONE
        );
        
    }
    
    protected override void activate () {
        
        var main_window = new MainWindow (this);
        main_window.show_all ();
        
        var provider = new Gtk.CssProvider ();
        provider.load_from_resource ("/com/github/rippieuk/rconnman/Application.css");
        Gtk.StyleContext.add_provider_for_screen (
            Gdk.Screen.get_default (),
            provider,
            Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION
        );
    }
    
    public static int main (string[] args) {
        Application app = new Application ();
        return app.run (args);
    }
}
