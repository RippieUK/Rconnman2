public class RConnMan.AboutDialog : Gtk.AboutDialog {
    public AboutDialog (Gtk.Window window) {
        Object ();
        set_destroy_with_parent (true);
        set_transient_for (window);
        set_modal (true);
        
        authors = {"Ronnie Jorgensen"};
        artists = {"Micah Ilbery https://github.com/micahilbery"};
        documenters = null;
        logo_icon_name = "com.github.rippieuk.rconnman";
        program_name = "Remote Connection Manager for Elemantary OS";
        comments = "Connect to your remote systems";
        copyright = "Copyright © 2020 Ronnie Jorgensen";
        version = @"v$(Application.APP_VERSION)";
        license = """Copyright (c) 2020 Ronnie Jorgensen (https://github.com/RippieUK)

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public
License as published by the Free Software Foundation; either
version 2 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
General Public License for more details.

You should have received a copy of the GNU General Public
License along with this program; if not, write to the
Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
Boston, MA 02110-1301 USA

Authored by: Ronnie Jorgensen <rippieuk@outlook.com>""";

        wrap_license = true;
        website = "https://github.com/RippieUK/rconnman";
        website_label = "Visit us on github.com";
        
        response.connect ((response_id) => {
           if (response_id == Gtk.ResponseType.CANCEL || response_id == Gtk.ResponseType.DELETE_EVENT) {
               hide_on_delete ();
           } 
        });
    }
}
