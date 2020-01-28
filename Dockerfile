FROM bioconductor/release_base2

ENV DEBIAN_FRONTEND=noninteractive
ENV R_LIBS_USER=$HOME/R
ENV R_LIBS_SITE=/opt/R
RUN apt-get update 
RUN apt-get -y install build-essential vim man tk libc6-dbg gdb valgrind libfreetype6-dev libarchive-dev
RUN wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /opt/miniconda.sh ; bash /opt/miniconda.sh -b -p /opt/miniconda ; /opt/miniconda/condabin/conda install -c bioconda -c conda-forge snakemake ; rm /opt/miniconda.sh
RUN wget https://github.com/singularityware/singularity/releases/download/2.5.2/singularity-2.5.2.tar.gz -O /opt/singularity.tar.gz ; tar xvf /opt/singularity.tar.gz ; rm /opt/singularity.tar.gz
WORKDIR /singularity-2.5.2/
RUN ./configure --prefix=/opt/singularity ; make ; sudo make install
CMD ["snakemake"]
