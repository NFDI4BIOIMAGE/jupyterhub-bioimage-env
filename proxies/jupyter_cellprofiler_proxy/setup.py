import setuptools

setuptools.setup(
    name="jupyter-cellprofiler-proxy",
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
