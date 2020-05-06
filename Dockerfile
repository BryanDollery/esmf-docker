from ubuntu

workdir /root/src/esmf

env ESMF_DIR=/root/src/esmf \
    ESMF_INSTALL_PREFIX=/usr/local/esmf \
    ESMF_OS=Linux \
    ESMF_NETCDF="local" \
    ESMF_COMM=mpiuni \
    ESMF_F90COMPILER=gfortran \
    ESMF_CXXCOMPILER=g++ \
    ESMF_TESTEXHAUSTIVE=on \
    ESMF_TESTSHAREDOBJ=on \
    ESMF_NETCDF_INCLUDE=/usr/include \
    ESMF_NETCDF_LIBS="-lnetcdf -lnetcdff" \
    ESMF_NETCDF_LIBPATH=/usr/local/lib \
    ESMF_BOPT=O3 \
    LANG=C.UTF-8 LC_ALL=C.UTF-8 \
    PATH /opt/conda/bin:$PATH

copy * /root/src/esmf

run add-apt-repository ppa:deadsnakes/ppa && \
    apt update && \
    apt upgrade && \
    apt install -qqy git tcsh pkg-config gfortran netcdf-bin libnetcdf-dev libnetcdff-dev openmpi-bin libopenmpi-dev bash vim curl wget jq zip unzip make build-essential libnetcdff6 software-properties-common python3.7 zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev ca-certificates bzip2 libglib2.0-0 libxext6 libsm6 libxrender1 && \
    apt clean -y && \
    apt autoclean -y && \
    apt autoremove -y && \
    make all && \
    make install && \
    make installcheck && \
    curl -LSs https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -o conda.sh && \
    chmod a+x conda.sh && \
    ./conda.sh -b -p /opt/conda && \
    ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate base" >> ~/.bashrc && \
    find /opt/conda/ -follow -type f -name '*.a' -delete && \
    find /opt/conda/ -follow -type f -name '*.js.map' -delete && \
    conda clean -afy && \
    curl -LSs https://github.com/krallin/tini/releases/latest -o tini.spec && \
    TINI_VERSION=$(cat tini.spec | grep -o "/v.*/" | head -15 | tail -1 | sed -r 's|/v(.*[^/])/|\1|') && \
    curl -LSs "https://github.com/krallin/tini/releases/download/v${TINI_VERSION}/tini_${TINI_VERSION}.deb" > tini.deb && \
    dpkg -i tini.deb && \
    rm tini.deb tini.spec && \
    conda update -n base -c defaults conda && \
    conda init bash && \
    conda env create

# ENTRYPOINT [ "/usr/bin/tini", "--"  ]
# CMD [ "/bin/bash"  ]




#     activate base && \
#     conda init

# shell ["conda", "run", "-n", "myesmf", "/bin/bash", "-c"]
# run conda env create -f env.yaml
# run activate espmy
# run conda install -n esmpy -c nesii -c conda-forge esmpy
# run activate esmpy

# run echo "\n\n\n\n\n\n\n\n\n\nPython Bit\n\n\n\n\n\n\n\n\n\n"


 
# run cd addon/ESMpy/ && \
#    kpython setup.py build --ESMFMKFILE=/usr/local/esmf/lib/libO3/Linux.gfortran.64.mpiuni.default/esmf.mk && \
#    python setup.py install

