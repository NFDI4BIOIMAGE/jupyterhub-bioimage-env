import setuptools

setuptools.setup(
    name="jupyter-cellpose-proxy",
    packages=setuptools.find_packages(),
	keywords=[ 'Jupyter', 'Xpra', 'Cellpose' ],
	classifiers=[ 'Framework :: Jupyter' ],
    install_requires=[
        'jupyter-server-proxy'
    ],
    entry_points={
        'jupyter_serverproxy_servers': [
            'cellpose = jupyter_cellpose_proxy:setup_cellpose',
        ]
    },
    package_data={
        'jupyter_cellpose_proxy': ['icons/Cellpose_Logo.svg'],
    },
)
