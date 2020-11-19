FROM  nvcr.io/nvidia/deepstream:5.0.1-20.09-base

RUN apt update && apt install --no-install-recommends -y \
    ca-certificates \
    wget \
    python3-dev \
    pkg-config \
    python3-pip \
    libgstreamer1.0-dev \
    libgirepository1.0-dev \
    git \
    python-gi \
    python-gi-dev \
    autoconf \
    automake \
    libtool \
    inetutils-ping \
    python3-gi \
    gstreamer1.0-tools \
    libcairo2-dev \
    gir1.2-gstreamer-1.0 \
    gir1.2-gst-plugins-base-1.0

WORKDIR /download
RUN /usr/bin/python3 -m pip install --upgrade pip setuptools wheel
RUN /usr/bin/python3 -m pip install protobuf numpy==1.18 cassandra-driver==3.18 scikit-learn==0.22.1 pandas==1.0.1 PyGObject prometheus_client onnx onnxruntime opencv-python kubernetes openshift-client

ENV PATH /usr/local/cuda/bin:${PATH}
ENV LD_LIBRARY_PATH=/opt/nvidia/deepstream/deepstream-5.0/lib:/opt/nvidia/deepstream/deepstream-5.0/lib/gst-plugins:/opt/conda/lib:/usr/lib:/usr/lib/x86_64-linux-gnu/lib:/usr/lib/x86_64-linux-gnu:/usr/local/cuda/lib64:/usr/local/cuda/lib64/stubs:${LD_LIBRARY_PATH}
ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES video,compute,utility
ENV GI_TYPELIB_PATH=/usr/lib/x86_64-linux-gnu/girepository-1.0/

COPY nv-tensorrt-repo-ubuntu1804-cuda10.2-trt7.2.1.6-ga-20201006_1-1_amd64.deb /download
RUN apt install -y ./nv-tensorrt-repo-ubuntu1804-cuda10.2-trt7.2.1.6-ga-20201006_1-1_amd64.deb
RUN cd /var/nv-tensorrt-repo-cuda10.2-trt7.2.1.6-ga-20201006 && apt install -y ./libcudnn8_8.0.4.30-1+cuda10.2_amd64.deb \
		   ./libnvinfer7_7.2.1-1+cuda10.2_amd64.deb \
		   ./libnvonnxparsers7_7.2.1-1+cuda10.2_amd64.deb \
		   ./libnvinfer-plugin7_7.2.1-1+cuda10.2_amd64.deb \
		   ./libnvparsers7_7.2.1-1+cuda10.2_amd64.deb \
		   ./python3-libnvinfer_7.2.1-1+cuda10.2_amd64.deb 

