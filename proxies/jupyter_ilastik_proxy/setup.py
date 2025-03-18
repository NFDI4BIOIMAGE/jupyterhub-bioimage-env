import setuptools

setuptools.setup(
    name="jupyter-ilastik-proxy",
    version='1.1dev',
    url="https://zivgitlab.uni-muenster.de/wwuit-sys/cloud-services/jupyterhub/jupyterhub-notebooks/",
    author="Ami Trivedi",
    description="ami.trivedi@uni-muenster.de",
    packages=setuptools.find_packages(),
	keywords=[ 'Jupyter', 'Xpra', 'Ilastik' ],
	classifiers=[ 'Framework :: Jupyter' ],
    install_requires=[
        'jupyter-server-proxy'
    ],
    entry_points={
        'jupyter_serverproxy_servers': [
            'ilastik = jupyter_ilastik_proxy:setup_ilastik',
        ]
    },
    package_data={
        'jupyter_ilastik_proxy': ['icons/ilastik_Logo.svg'],
    },
)
