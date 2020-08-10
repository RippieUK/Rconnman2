
public class RConnMan.Preferences : Gtk.Dialog {

    public const int MIN_WIDTH = 420;
    public const int MIN_HEIGHT = 300;

    public Preferences (Gtk.Window? parent) {
        Object (
            title: "Preferences",
            transient_for: parent,
            border_width: 6,
            deletable: false,
            destroy_with_parent: true,
            height_request: MIN_HEIGHT,
            width_request: MIN_WIDTH,
            resizable: false,
            window_position: Gtk.WindowPosition.CENTER_ON_PARENT
        );
    }

    construct {
        set_default_size (400,400);
        
        var use_dark_theme = new Gtk.Switch ();
        use_dark_theme.valign = Gtk.Align.CENTER;
        use_dark_theme.halign = Gtk.Align.START;
        Application.settings.bind ("dark-theme", use_dark_theme, "active", GLib.SettingsBindFlags.DEFAULT);
        
        var grid = new Gtk.Grid ();
        grid.margin_top = 0;
        grid.margin = 6;
        grid.column_spacing = 12;
        grid.column_homogeneous = true;
        grid.attach (use_dark_theme, 0, 1, 1, 1);

        ((Gtk.Container) get_content_area ()).add (grid);

        var close_button = this.add_button ("Close", Gtk.ResponseType.CLOSE);
        ((Gtk.Button) close_button).clicked.connect (() => destroy ());
    }

}
