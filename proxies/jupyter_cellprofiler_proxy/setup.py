import setuptools

setuptools.setup(
    name="jupyter-cellprofiler-proxy",
    version='1.1dev',
    url="https://zivgitlab.uni-muenster.de/wwuit-sys/cloud-services/jupyterhub/jupyterhub-notebooks/",
    author="Ami Trivedi",
    description="ami.trivedi@uni-muenster.de",
    packages=setuptools.find_packages(),
	keywords=[ 'Jupyter', 'Xpra', 'Cellprofiler' ],
	classifiers=[ 'Framework :: Jupyter' ],
    install_requires=[
        'jupyter-server-proxy'
    ],
    entry_points={
        'jupyter_serverproxy_servers': [
            'cellprofiler = jupyter_cellprofiler_proxy:setup_cellprofiler',
        ]
    },
    package_data={
        'jupyter_cellprofiler_proxy': ['icons/cellprofiler.svg'],
    },
)
