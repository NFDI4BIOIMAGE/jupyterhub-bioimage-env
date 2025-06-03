## 🧬 JupyterHub Bioimage Environment

A **JupyterHub-based Docker image** with a pre-configured **Python environment**, including a wide range of tools for bioimage analysis such as:

- [CellProfiler](https://cellprofiler.org/)
- [Cellpose](https://www.cellpose.org/)
- [Fiji](https://fiji.sc/)
- [Ilastik](https://www.ilastik.org/)
- [QuPath](https://qupath.github.io/)

---

## 📦 Overview

This repository outlines the Docker image configuration and Jupyter proxy integration used to support image analysis tools.

Currently, the image is based on the **University of Münster JupyterHub image**. However, we are planning to build a separate, standalone image to ensure accessibility and compatibility with various JupyterHub instances.

To build the image yourself, you can start with either:

- A standard Linux base image (e.g., `ubuntu`, `debian`)
- A JupyterHub notebook base image (e.g., from [Jupyter Docker Stacks](https://jupyter-docker-stacks.readthedocs.io/en/latest/))

Make sure to install the necessary components, including:

- `noVNC`
- `X11`
- Other required dependencies for your image analysis tools

This setup enables support for **GUI-based applications** within the Jupyter notebook interface.

---

## 🧰 Installed Bioimage Tools and Plugins

| No. | Tool         | Version     | Plugins                                                                 |
|-----|--------------|-------------|-------------------------------------------------------------------------|
| 1   | CellProfiler | v4.2.7      | cellpose, imagejscript, omnipose                                                                      |
| 2   | Cellpose     | v2.0.5      | –                                                                       |
| 3   | Fiji         | 2.14.0      | OMERO-Fiji (v5.8.6), MorphoLibJ, simple-omero-client, omero-macro-extension |
| 4   | Ilastik      | v1.4.0      | –                                                                       |
| 5   | QuPath       | v0.5.1      | Cellpose (0.9.6), StarDist, OMERO extension                             |

---

## 🔗 Useful Links

- [JupyterHub](https://jupyter.org/hub)
- [Jupyter Docker Stacks](https://jupyter-docker-stacks.readthedocs.io/en/latest/)
- [OMERO](https://www.openmicroscopy.org/omero/)

---

## 📄 License

This project is released under the MIT License. See the [LICENSE](./LICENSE) file for details.

---








