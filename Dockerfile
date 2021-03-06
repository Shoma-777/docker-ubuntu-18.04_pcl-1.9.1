FROM ubuntu:18.04

MAINTAINER Shoma Kimura <m5182107.s@gmail.com>

ARG DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y --no-install-recommends \
    build-essential cmake clang ninja-build git \
    libboost-all-dev \
    libeigen3-dev \
    libflann-dev \
    libqhull-dev \
    libvtk7-dev \
    libopenni-dev \
    libopenni2-dev \
    && apt clean

RUN git config --global http.sslVerify false

RUN git clone -b pcl-1.9.1 --depth 1 https://github.com/PointCloudLibrary/pcl.git \
    && cd pcl \
    && mkdir build && cd build \
    && cmake -G Ninja -D CMAKE_BUILD_TYPE=Release -D CMAKE_C_COMPILER=clang -D CMAKE_CXX_COMPILER=clang++ .. \
    && ninja && ninja install && ninja clean \
    && ldconfig \
    && cd / && rm -rf /pcl

