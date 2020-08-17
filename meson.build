project('com.github.rippieuk.rconnman', 'vala', 'c')
gnome = import('gnome')

asresources = gnome.compile_resources(
  'as-resources', 'data/' + meson.project_name() + '.gresource.xml',
  source_dir: 'data',
  c_name: 'as'
)

executable(
    meson.project_name(),
    'src/Application.vala',
    'src/Widgets/MainWindow.vala',
    'src/Widgets/HeaderBar.vala',
    'src/Widgets/Preferences.vala',
    'src/Widgets/LeftPaneView.vala',
    'src/Widgets/AboutDialog.vala',
    'src/Widgets/WelcomeView.vala',
    asresources,
    dependencies: [
        dependency('gtk+-3.0'),
        dependency('granite')
    ],
    install: true
)

install_data(
    join_paths('data', meson.project_name() + '.desktop'),
    install_dir: join_paths(get_option('datadir'), 'applications')
)

install_data(
    join_paths('data', meson.project_name() + '.appdata.xml'),
    install_dir: join_paths(get_option('datadir'), 'metainfo')
)

subdir('data')

meson.add_install_script('meson/post_install.py')
