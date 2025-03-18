#ARG VERSION=v3.3.0
#FROM harbor.uni-muenster.de/jupyterhub/escience:$VERSION
# use base image for least software
ARG VERSION=v3.3.0
FROM harbor.uni-muenster.de/jupyterhub/base:$VERSION

ENV LD_LIBRARY_PATH=/usr/lib:$LD_LIBRARY_PATH 

USER root:root

RUN apt-get update &&\
  apt-get install libxml2-dev libssl-dev -y 

#RUN unset https_proxy http_proxy HTTPS_PROXY HTTP_PROXY &&\
#    rm /etc/curlrc \#
#	/usr/lib/R/etc/Renviron.site
ARG version=4.2.7
ENV DISPLAY=:0
RUN apt update;\
      apt -y upgrade;\
      apt install software-properties-common;\
      add-apt-repository ppa:deadsnakes/ppa;\
      apt install -y python3.8;\
      apt install -y make gcc build-essential libgtk-3-dev wget git;\
      apt install -y python3-pip openjdk-11-jdk-headless libnotify-dev libsdl2-dev libwebkit2gtk-4.0-dev libiconv-hook-dev;\
      apt-get install -y pkg-config python3-dev libnotify4 libmysqlclient-dev build-essential;\
      apt-get install -y default-jre xz-utils curl;\
      apt install default-jdk python3-dev g++ libffi-dev freeglut3-dev xvfb;\
      apt install -y ssh xauth xorg

RUN apt install -y python3-virtualenv;\
      apt install -y python3.8-venv;\
      apt install -y python3-setuptools;\
      export PATH=$PATH:/home/ubuntu/.local/bin;\
      apt install -y python3.8-distutils;\
      apt-get install -y python3.8-dev libbz2-dev sudo

ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
# Add Conda to the PATH
ENV PATH=/opt/conda/bin:$PATH

ENV MYSQLCLIENT_CFLAGS=-I/usr/include/mysql
ENV MYSQLCLIENT_LDFLAGS=-L/usr/lib/x86_64-linux-gnu



# Create and activate the CellProfiler environment with Python 3.8
RUN conda create -n cellprofiler python=3.8 -y && \
    conda config --add channels bioconda && \
    conda config --add channels conda-forge && \
    conda config --add channels nvidia
#RUN pip3 install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu118
RUN PATH=/usr/local/cuda-11.8/bin:$PATH
RUN LD_LIBRARY_PATH=/usr/local/cuda-11.8/lib64:$LD_LIBRARY_PATH


   
        

# Install Python dependencies in the CellProfiler environment
RUN /bin/bash -c "source activate cellprofiler && \
    pip install numpy==1.23.0 && \
    conda install -y cython pandas scipy scikit-learn matplotlib seaborn && \
    pip install https://extras.wxpython.org/wxPython4/extras/linux/gtk3/ubuntu-22.04/wxPython-4.2.0-cp38-cp38-linux_x86_64.whl && \
    pip install https://github.com/glencoesoftware/zeroc-ice-py-linux-x86_64/releases/download/20240202/zeroc_ice-3.6.5-cp38-cp38-manylinux_2_28_x86_64.whl && \
    conda install -c conda-forge typing_extensions && \
    pip install jpype1 && \
    conda install -c conda-forge mysqlclient mysql && \
    pip install python-javabridge --no-cache-dir --no-build-isolation && \
    pip install centrosome --no-cache-dir --no-build-isolation && \
    pip install git+https://github.com/mouseland/cellpose.git && \
    pip install cellpose[gui] && \
    pip install ezomero && \
    pip install cellpose[omniverse] && \
    pip install stardist && \
    pip uninstall -y tensorflow && \
    pip uninstall -y tensorflow-estimator && \
    conda install -c conda-forge cudatoolkit==11.8 && \
    pip install --upgrade nvidia-cudnn-cu11==8.6.0.163 && \
    conda install -c conda-forge jupyterlab_widgets && \
    conda install -c conda-forge ipywidgets && \
    pip install bia-bob && \
    pip install stackview && \
    pip install pyclesperanto && \
    pip install tensorflow[and-cuda]==2.12.0"
     
# Clone the CellProfiler and plugins repositories
WORKDIR /opt
RUN git clone --branch v4.2.7 https://github.com/CellProfiler/CellProfiler.git
WORKDIR /opt/CellProfiler
RUN /bin/bash -c "source activate cellprofiler && pip install ."

WORKDIR /opt
RUN git clone https://github.com/CellProfiler/CellProfiler-plugins.git
WORKDIR /opt/CellProfiler-plugins
RUN /bin/bash -c "source activate cellprofiler && \
              pip install -e .[cellpose] && \
              pip install -e .[imagejscript] && \
               pip install -e .[omnipose]"


# Copy the script to download CellPose models and run it
COPY ./config/download_cellpose_models.py /
RUN /bin/bash -c "source activate cellprofiler && python /download_cellpose_models.py"
RUN /bin/bash -c "conda run -n cellprofiler conda install -y ipykernel && conda run -n cellprofiler python -m ipykernel install --name cellprofiler --display-name 'Python Cellprofiler'"



   

# Install Fiji (ImageJ) 
WORKDIR /opt
RUN wget https://downloads.imagej.net/fiji/latest/fiji-linux64.zip && \
    unzip fiji-linux64.zip -d /opt/Fiji && \
    rm fiji-linux64.zip
ENV PATH="/opt/Fiji/Fiji.app:$PATH"

# Set Fiji's plugins directory
ENV FIJI_PATH="/opt/Fiji/Fiji.app"

# Install OMERO-Fiji Plugin version=5.8.6
RUN mkdir -p $FIJI_PATH/plugins 
WORKDIR $FIJI_PATH/plugins
RUN wget https://github.com/ome/omero-insight/releases/download/v5.8.6/omero_ij-5.8.6-all.jar



WORKDIR /opt
# Install QuPath binary version : 0.5.1 latest
RUN wget https://github.com/qupath/qupath/releases/download/v0.5.1/QuPath-v0.5.1-Linux.tar.xz && \
    tar -xf QuPath-v0.5.1-Linux.tar.xz && \
    rm QuPath-v0.5.1-Linux.tar.xz && \
    chmod a+x /opt/QuPath-v0.5.1-Linux/QuPath/bin/QuPath 
    

RUN chown -R root:root /opt/QuPath-v0.5.1-Linux 
# Install cellpose (0.9.6), stardist and omero extension for QuPath
RUN mkdir /opt/QuPath-v0.5.1-Linux/QuPath/lib/app/extensions
WORKDIR /opt/QuPath-v0.5.1-Linux/QuPath/lib/app/extensions
RUN wget https://github.com/BIOP/qupath-extension-cellpose/releases/download/v0.9.6/qupath-extension-cellpose-0.9.6.zip && \
    unzip qupath-extension-cellpose-0.9.6.zip && \
    rm qupath-extension-cellpose-0.9.6.zip && \
    wget https://github.com/qupath/qupath-extension-stardist/releases/download/v0.5.0/qupath-extension-stardist-0.5.0.jar && \
    wget https://github.com/qupath/qupath-extension-omero/releases/download/v0.1.0-rc5/qupath-extension-omero-0.1.0-rc5.jar

# Create and activate conda environment for samapi with python 3.10
RUN conda create -n samapi python=3.10 -y 
WORKDIR /opt/QuPath-v0.5.1-Linux/QuPath/lib/app/extensions
RUN wget https://github.com/ksugar/qupath-extension-sam/releases/download/v0.7.0/qupath-extension-sam-0.7.0.jar
RUN /bin/bash -c "source activate samapi && python -m pip install git+https://github.com/ksugar/samapi.git"


# Install Ilastik
WORKDIR /opt
RUN wget https://files.ilastik.org/ilastik-1.4.0.post1-Linux.tar.bz2 && \
    tar xjf ilastik-1.4.0.post1-Linux.tar.bz2 && \
    rm ilastik-1.4.0.post1-Linux.tar.bz2
ENV PATH="/opt/ilastik-1.4.0b23-Linux:$PATH"


COPY ./config/script.groovy /opt  


COPY   ./config/CellProfilerLocal.cfg /tmp/
RUN mkdir -p /opt/proxies 
    
COPY ./proxies/ /opt/proxies
 
RUN pip install --no-cache-dir \
      "notebook>=4" \  
    /opt/proxies/jupyter_cellprofiler_proxy \
    /opt/proxies/jupyter_cellpose_proxy \
    /opt/proxies/jupyter_fiji_proxy \
    /opt/proxies/jupyter_ilastik_proxy \
   /opt/proxies/jupyter_qupath_proxy 
   
#COPY ./config/CellProfilerLocal.cfg /tmp/

WORKDIR /usr/local/src
USER nobody
