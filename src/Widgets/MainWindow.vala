/*
* Copyright (c) 2011-2018 Your Organization (https://github.com/RippieUK/RConnman2)
*
* This program is free software; you can redistribute it and/or
* modify it under the terms of the GNU General Public
* License as published by the Free Software Foundation; either
* version 2 of the License, or (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
* General Public License for more details.
*
* You should have received a copy of the GNU General Public
* License along with this program; if not, write to the
* Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
* Boston, MA 02110-1301 USA
*
* Authored by: Ronnie Jorgensen <rippieuk@outlook.com>
*/

public class MainWindow : Gtk.ApplicationWindow {
    
    public MainWindow (Gtk.Application app) {
        Object (
            application: app
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
        
        var headerbar = new HeaderBar ();
        set_titlebar (headerbar);
        
        var my_switch = new Gtk.Switch ();
        Application.settings.bind ("useless-setting", my_switch, "active", GLib.SettingsBindFlags.DEFAULT);
        
        var gtk_settings = Gtk.Settings.get_default ();
        
        var use_dark_theme = new Gtk.Switch ();
        Application.settings.bind ("dark-theme", use_dark_theme, "active", GLib.SettingsBindFlags.DEFAULT);
        Application.settings.bind ("dark-theme", gtk_settings, "gtk-application-prefer-dark-theme", GLib.SettingsBindFlags.DEFAULT);
        
        var main_grid = new Gtk.Grid ();
        
        main_grid.attach (new Gtk.Label ("Useless Setting"), 0, 0, 1, 1);
        main_grid.attach (my_switch, 1, 0, 1, 1);
        
        main_grid.attach (new Gtk.Label ("Prefer Dark Theme"), 0, 1, 1, 1);
        main_grid.attach (use_dark_theme, 1, 1, 1, 1);
        
        add (main_grid);
        
    }
    
    public override bool delete_event (Gdk.EventAny event) {
        int width, height, x ,y;
        
        get_size (out width, out height);
        Application.settings.set ("window-size", "(ii)", width, height);
        
        get_position (out x, out y);
        Application.settings.set ("window-position", "(ii)", x, y);

        return false;
    }
      
}
