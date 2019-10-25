FROM gitpod/workspace-full:latest

USER root
RUN apt-get update && apt-get install -y \
  cloc graphviz \
  && apt-get clean && rm -rf /var/cache/apt/* && rm -rf /var/lib/apt/lists/* && rm -rf /tmp/*
  
USER gitpod
RUN wget https://repo.continuum.io/archive/Anaconda3-5.0.1-Linux-x86_64.sh
RUN bash Anaconda3-5.0.1-Linux-x86_64.sh -b
RUN rm Anaconda3-5.0.1-Linux-x86_64.sh
ENV PATH=$PATH:$HOME/anaconda3
ENV PATH=$PATH:$HOME/anaconda3/bin
RUN conda install conda
RUN conda init
RUN ["/bin/bash", "-c", ". /home/gitpod/anaconda3/etc/profile.d/conda.sh && conda activate base && pip install simplejson radon"]
RUN ["/bin/bash", "-c", ". /home/gitpod/anaconda3/etc/profile.d/conda.sh && conda activate base && conda install -c conda-forge pygit2"]
RUN echo "conda activate base" > ~/.bashrc
ENV jupynb="jupyter notebook --NotebookApp.allow_origin=\'$(gp url 8888)\' --ip='*' --NotebookApp.token='' --NotebookApp.password=''"

USER root
