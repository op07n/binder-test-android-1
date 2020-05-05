FROM jupyter/scipy-notebook:45f07a14b422


ARG NB_USER=jovyan
ARG NB_UID=1000
ENV USER ${NB_USER}
ENV NB_UID ${NB_UID}
ENV HOME /home/${NB_USER}

WORKDIR ${HOME}

USER root

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update

RUN apt-get install -y --no-install-recommends git build-essential autoconf vim wget unzip sudo xserver-xorg openjdk-11-jre cmake libtool build-essential pkg-config autogen ocaml ocamlbuild bison flex texinfo python-dev python-mako python-six swig3.0 python3-mako python3-numpy

RUN apt-get -y install --fix-missing software-properties-common 
RUN add-apt-repository -y ppa:ubuntu-toolchain-r/test

RUN apt -y install gcc-9 g++-9
RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-9 90 --slave /usr/bin/g++ g++ /usr/bin/g++-9 --slave /usr/bin/gcov gcov /usr/bin/gcov-9


RUN rm -rf /var/lib/apt/lists/*







RUN chown -R ${NB_UID} ${HOME}
USER ${USER}







RUN mkdir -p /home/${NB_USER}/src
WORKDIR /home/${NB_USER}/src

RUN git clone --recursive https://github.com/bastibl/gnuradio-android.git

WORKDIR /home/${NB_USER}/src/gnuradio-android/thrift
RUN git clean -xdf
RUN ./bootstrap.sh
RUN ./configure --disable-tests --disable-tutorial --with-cpp --without-python --without-qt4 --without-qt5 --without-py3 --without-go --without-nodejs --without-c_glib --without-php --without-csharp --without-java --without-libevent --without-zlib
RUN make -j $(getconf _NPROCESSORS_ONLN)
RUN sudo make install






l

WORKDIR /home/${NB_USER}/src
RUN wget https://redirector.gvt1.com/edgedl/android/studio/ide-zips/3.6.3.0/android-studio-ide-192.6392135-linux.tar.gz
RUN tar xvf android-studio-ide-192.6392135-linux.tar.gz
RUN rm android-studio-ide-192.6392135-linux.tar.gz

RUN wget https://dl.google.com/android/repository/commandlinetools-linux-6200805_latest.zip
RUN unzip commandlinetools-linux-6200805_latest.zip

RUN mkdir -p /home/${NB_USER}/Android/Sdk
ENV ANDROID_HOME /home/${NB_USER}/Android/Sdk
WORKDIR /home/${NB_USER}/src/tools/bin





















ENV PATH="${PATH}:${HOME}/.dotnet/tools"
RUN echo "$PATH"



# Set root to Notebooks
WORKDIR ${HOME}/Notebooks/


