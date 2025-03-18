import os

def setup_fiji():
    def _fiji_command(port):
        return [ "/usr/bin/startvnc", str(port), "17", "/opt/Fiji/Fiji.app/ImageJ-linux64" ]

    return {
        'command' : _fiji_command,
        'environment' : {},
        'timeout' : 120,
        'launcher_entry' : {
            'title' : 'Fiji',
            'category': 'X11 Applications',
            'icon_path' : os.path.join(os.path.dirname(os.path.abspath(__file__)), 'icons', 'Fiji_Logo.svg')
        }
    }
