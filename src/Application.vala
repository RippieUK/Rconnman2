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

public class Application : Gtk.Application {
    
    public static GLib.Settings settings;
    static construct {
        settings = new GLib.Settings ("com.github.rippieuk.rconnman");
    }
    
    public Application () {
        Object (
            application_id: "com.github.rippieuk.rconnman",
            flags: ApplicationFlags.FLAGS_NONE
        );
        
    }
    
    protected override void activate () {
        
        var app_window = new MainWindow (this);
        
        var gtk_settings = Gtk.Settings.get_default ();
        gtk_settings.gtk_application_prefer_dark_theme = settings.get_boolean ("dark-style");
        
        // int window_x, window_y;
        // var rect = Gtk.Allocation ();

        // settings.get ("window-position", "(ii)", out window_x, out window_y);
        // settings.get ("window-size", "(ii)", out rect.width, out rect.height);

        // if (window_x != -1 ||  window_y != -1) {
        //     app_window.move (window_x, window_y);
        // }

        // app_window.set_allocation (rect);

        // if (settings.get_boolean ("window-maximized")) {
        //     app_window.maximize ();
        // }
        
        app_window.show_all ();
    }
    
    public static int main (string[] args) {
        return new Application ().run (args);
    }
}
