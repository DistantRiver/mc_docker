FROM nvidia/cuda:9.0-runtime-ubuntu16.04
ENV PATH /opt/conda/bin:$PATH

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    "build-essential=12.4ubuntu1" \
    "libboost-all-dev=1.65.1.0ubuntu1" \
    "libboost-dev=1.65.1.0ubuntu1" \
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