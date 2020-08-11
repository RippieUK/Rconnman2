public class RConnMan.WelcomeView : Gtk.Grid {
    construct {
        var welcome = new Granite.Widgets.Welcome ("Remote Connection Manager", "Connect to SSH and RDP sessions.");
        welcome.append ("document-new", "Visit Valadoc", "The canonical source for Vala API references.");
        welcome.append ("window-new", "RConnMan Source", "RConnMan's source code is hosted on GitHub.");

        add (welcome);

        welcome.activated.connect ((index) => {
            switch (index) {
                case 0:
                    try {
                        AppInfo.launch_default_for_uri ("https://valadoc.org/granite/Granite.html", null);
                    } catch (Error e) {
                        warning (e.message);
                    }

                    break;
                case 1:
                    try {
                        AppInfo.launch_default_for_uri ("https://github.com/RippieUK/Rconnman2", null);
                    } catch (Error e) {
                        warning (e.message);
                    }

                    break;
            }
        });
    }
}
