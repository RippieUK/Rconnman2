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

public class Rconnman : Gtk.Application {
    public Rconnman () {
        Object (
            application_id: "com.github.rippieuk.rconnman",
            flags: ApplicationFlags.FLAGS_NONE
        );
    }
    
    protected override void activate () {
        var main_window = new Gtk.ApplicationWindow (this) {
            default_height = 800,
            default_width = 600,
            title = "Hello World"
        };
        
        var label = new Gtk.Label ("Remote Connection Manager");
        
        main_window.add (label);
        main_window.show_all ();
    }
    
    public static int main (string[] args) {
        return new Rconnman ().run (args);
    }
}