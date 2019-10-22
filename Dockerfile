FROM nvidia/cuda:9.0-runtime-ubuntu16.04
ENV PATH /opt/conda/bin:$PATH

RUN apt-get update --fix-missing \
    && apt-get install -y wget bzip2 ca-certificates \
    libglib2.0-0 libxext6 libsm6 libxrender1 \
    git mercurial subversion \
    && apt-get install -y --no-install-recommends \
    "build-essential" \
    "libboost-all-dev" \
    "libboost-dev" \
    && rm -rf /var/lib/apt/lists/*

RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh && \
    /bin/bash ~/miniconda.sh -b -p /opt/conda && \
    rm ~/miniconda.sh && \
    echo "source activate base" >> ~/.bashrc

RUN conda update conda -n root && conda install --yes \
    python==2.7.5 \
    tensorflow-gpu==1.8.0 \
    && conda clean --yes --all

RUN pip install --upgrade \
    dm-sonnet==1.10 \
    matplotlib==2.2.3