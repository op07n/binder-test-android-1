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

RUN apt-get install -y --no-install-recommends git vim wget unzip sudo xserver-xorg openjdk-11-jre cmake libtool build-essential pkg-config autogen ocaml ocamlbuild bison flex texinfo python-dev python-mako python-six swig3.0 python3-mako python3-numpy

RUN apt-get -y install --fix-missing software-properties-common 
RUN add-apt-repository -y ppa:ubuntu-toolchain-r/test

RUN apt -y install gcc-9 g++-9
RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-9 90 --slave /usr/bin/g++ g++ /usr/bin/g++-9 --slave /usr/bin/gcov gcov /usr/bin/gcov-9


RUN rm -rf /var/lib/apt/lists/*


# Set root to Notebooks
WORKDIR ${HOME}/Notebooks/
