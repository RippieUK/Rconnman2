<p align="center">
    <img src="data/icons/64/com.github.rippieuk.rconnman.svg" alt="AppIcon" />
</p>

# Remote Connection Manager

Remote Connection Manager is my own very first starter project for building an App for the Elementary OS. 

The initial plan is for it to create connections to remote systems using SSH, Telnet and RDP.

## Screenshots
![Screenshot](data/rconnman_screenshot.png)

## Developing and Building

You will need the following dependencies if you want to hack away:

* libgranite-dev
* libgtk-3-dev
* meson
* valac

Run `meson build` to configure the build environment

    meson build --prefix=/usr
    cd build

To install, use `ninja install`, then execute with `com.github.rippieuk.rconnman`

    sudo ninja install
    com.github.rippieuk.rconnman

## Credits where credits due

Vala teacher: David Hewitt @ https://github.com/davidmhewitt
<br />
App icon credits: Micah Ilbery @ https://github.com/micahilbery 
