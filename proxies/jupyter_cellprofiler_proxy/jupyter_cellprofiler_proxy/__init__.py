import os

def setup_cellprofiler():
    def _cellprofiler_command(port):
        return [ "/usr/bin/startvnc", str(port), "15", "/opt/conda/envs/cellprofiler/bin/cellprofiler" ]

    return {
        'command' : _cellprofiler_command,
        'environment' : {},
        'timeout' : 120,
        'launcher_entry' : {
            'title' : 'Cellprofiler',
            'category': 'X11 Applications',
            'icon_path' : os.path.join(os.path.dirname(os.path.abspath(__file__)), 'icons', 'cellprofiler.svg')
        }
    }
