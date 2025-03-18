## Dockerfile for creating python environment (includes cellprofiler and cellpose for Image Analysis) on jupyterhub 
 

Building Docker File

```
docker build . -t pythonenv

# run on jupyter lab

sudo docker run --name bioimage --rm --net=host -w "/usr/local/src" -e HOME="/tmp" pythonenv:latest jupyter lab --ip 0.0.0.0 



# execute docker container at bash
docker exec -itu root pythonenv bash


# Bioimage Analysis image for group x0cimmin (MIC)


# Docker image you can found on harbor under projects/jupyterhub/imaging:v1
```




