public class HostConfig : GLib.Object {
    
    construct {
        string path = Path.build_filename (GLib.Environment.get_user_config_dir (), "rconnman", "hosts.json");
        
        File file = File.new_for_path (path);
        if (file.query_exists()) {
            print ("File exists!\n");
        } else {
            print ("File do not exists :(\n");
            print ("Let's create file!\n");
            
            string configPath = Path.build_filename (GLib.Environment.get_user_config_dir (), "rconnman");
            GLib.DirUtils.create_with_parents (configPath, 0700);
        
            try {
                file.create (FileCreateFlags.NONE);
            }
            catch (Error e) {
                print ("Error: %s\n", e.message);

                //  var message_dialog = new Granite.MessageDialog.with_image_from_icon_name (
                //      "Unable to create file!",
                //      "The error is: %s".printf (e.message),
                //      "applications-development",
                //      Gtk.ButtonsType.CLOSE
                //   );

                //   message_dialog.run ();
            }
        }
    }
}
