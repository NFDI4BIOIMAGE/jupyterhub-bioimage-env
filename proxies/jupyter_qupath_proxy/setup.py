import setuptools

setuptools.setup(
    name="jupyter-qupath-proxy",
    version='1.1dev',
    url="https://zivgitlab.uni-muenster.de/wwuit-sys/cloud-services/jupyterhub/jupyterhub-notebooks/",
    author="Ami Trivedi",
    description="ami.trivedi@uni-muenster.de",
    packages=setuptools.find_packages(),
	keywords=[ 'Jupyter', 'Xpra', 'QuPath' ],
	classifiers=[ 'Framework :: Jupyter' ],
    install_requires=[
        'jupyter-server-proxy'
    ],
    entry_points={
        'jupyter_serverproxy_servers': [
            'qupath = jupyter_qupath_proxy:setup_qupath',
        ]
    },
    package_data={
        'jupyter_qupath_proxy': ['icons/qupath.svg'],
    },
)
