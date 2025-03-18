import os

def setup_qupath():
    def _qupath_command(port):
        qupath_path = "/opt/QuPath-v0.5.1-Linux/QuPath/bin/QuPath"
        groovy_script = "/opt/script.groovy"
        os.system(f"{qupath_path} script {groovy_script} --save")
        return [ "/usr/bin/startvnc", str(port), "19", "/opt/QuPath-v0.5.1-Linux/QuPath/bin/QuPath" ]

    return {
        'command' : _qupath_command,
        'environment' : {},
        'timeout' : 120,
        'launcher_entry' : {
            'title' : 'QuPath',
            'category': 'X11 Applications',
            'icon_path' : os.path.join(os.path.dirname(os.path.abspath(__file__)), 'icons', 'qupath.svg')
        }
    }



# qupath="/opt/QuPath-v0.5.1-Linux/QuPath/bin/QuPath.sh"
        # $qupath script /opt/ --save
        #$qupath script /opt/script.groovy --save