import setuptools

setuptools.setup(
    name="jupyter-fiji-proxy",
    packages=setuptools.find_packages(),
	keywords=[ 'Jupyter', 'Xpra', 'Fiji' ],
	classifiers=[ 'Framework :: Jupyter' ],
    install_requires=[
        'jupyter-server-proxy'
    ],
    entry_points={
        'jupyter_serverproxy_servers': [
            'fiji = jupyter_fiji_proxy:setup_fiji',
        ]
    },
    package_data={
        'jupyter_fiji_proxy': ['icons/Fiji_Logo.svg'],
    },
)
