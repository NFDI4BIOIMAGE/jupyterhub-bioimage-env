import os

def setup_ilastik():
    def _ilastik_command(port):
        return [ "/usr/bin/startvnc", str(port), "18", "/opt/ilastik-1.4.0.post1-Linux/run_ilastik.sh" ]

    return {
        'command' : _ilastik_command,
        'environment' : {},
        'timeout' : 120,
        'launcher_entry' : {
            'title' : 'Ilastik',
            'category': 'X11 Applications',
            'icon_path' : os.path.join(os.path.dirname(os.path.abspath(__file__)), 'icons', 'ilastik_Logo.svg')
        }
    }
