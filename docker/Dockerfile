ARG PYTORCH="1.6.0"
ARG CUDA="10.1"
ARG CUDNN="7"

FROM pytorch/pytorch:${PYTORCH}-cuda${CUDA}-cudnn${CUDNN}-devel

ENV TORCH_CUDA_ARCH_LIST="6.0 6.1 7.0+PTX"
ENV TORCH_NVCC_FLAGS="-Xfatbin -compress-all"
ENV CMAKE_PREFIX_PATH="$(dirname $(which conda))/../"

RUN apt-get update && apt-get install -y ffmpeg libsm6 libxext6 git ninja-build libglib2.0-0 libsm6 libxrender-dev libxext6 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install MMCV
#RUN pip install mmcv-full==1.3.8 -f https://download.openmmlab.com/mmcv/dist/cu101/torch1.6.0/index.html

RUN mkdir -p /root/conf
COPY base-conf /root/conf
RUN mkdir -p  ~/.pip
RUN cp /root/conf/pip.conf ~/.pip/pip.conf

RUN pip install opencv-python==3.4.2.17
ADD mmcv_full-1.3.8-cp37-cp37m-manylinux1_x86_64.whl ./mmcv_full-1.3.8-cp37-cp37m-manylinux1_x86_64.whl
RUN pip install mmcv_full-1.3.8-cp37-cp37m-manylinux1_x86_64.whl

# Install MMDetection
RUN conda clean --all
#RUN git clone https://github.com/open-mmlab/mmdetection.git /mmdetection
ADD ./v2.15.1.tar.gz /
WORKDIR /mmdetection-2.15.1
ENV FORCE_CUDA="1"
RUN pip install -r requirements/build.txt
RUN pip install --no-cache-dir -e .

RUN ln -s /mmdetection-2.15.1 /app

WORKDIR /app

RUN conda install -c conda-forge jupyterlab -y

ENV HYPC_JUPYTER_LAB_API_TOKEN=x123456789

ADD ./start-notebook.sh /root/start-notebook.sh

RUN apt-get update && apt-get install wget

RUN apt-get install curl -y

SHELL ["/bin/bash", "-c"] 

RUN pip install onnx onnx-simplifier
# do not install onnxruntime-gpu, onnx-simpliefier current can only use onnxruntime, after onnx converted, then use onnxruntime-gpu to run
CMD ["sh","/root/start-notebook.sh"]
