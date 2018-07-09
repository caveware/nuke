# project name and programming language
project('com.github.caveware.nuke', 'vala', 'c')

# Include the translations module
i18n = import('i18n')

# Set our translation domain
add_global_arguments('-DGETTEXT_PACKAGE="@0@"'.format (meson.project_name()), language:'c')

# Add maths library, when required
cc = meson.get_compiler('c')
m_dep = cc.find_library('m', required: false)

# Create a new executable, list the files we want to compile, list the dependencies we need, and install
executable(
    meson.project_name(),
    'src/DurationSelector.vala',
    'src/Main.vala',
    'src/WattageRow.vala',
    'src/WattageSelector.vala',
    dependencies: [
        dependency('gtk+-3.0'),
        m_dep
    ],
    install: true
)

subdir('data')
subdir('po')
