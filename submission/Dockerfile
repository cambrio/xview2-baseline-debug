# Debug version to figure out what's going on with paths, permissions, memory, swap, etc

FROM ubuntu

# Updating the image 
RUN apt update && \
    apt install -y apt-transport-https

# Installing all dependencies 
RUN apt install -y python3 python3-pip curl git

# Making python3 the default Python 
RUN ln -s /usr/bin/python3 /usr/bin/python

# Running the rest as non-root
RUN groupadd -g 999 appuser && \
    useradd -r -u 999 -g appuser appuser && \
    mkdir -p /home/appuser/.keras/models && \
    usermod -a -G sudo appuser && \
    chown -R appuser:appuser /home/appuser

ADD https://github.com/fchollet/deep-learning-models/releases/download/v0.2/resnet50_weights_tf_dim_ordering_tf_kernels_notop.h5 /home/appuser/.keras/models/resnet50_weights_tf_dim_ordering_tf_kernels_notop.h5

RUN chmod -R 777 /home/appuser/

USER appuser

SHELL ["/bin/bash", "-c"]

# Making the appropate directories for the inference code, inputs, and outputs
RUN mkdir -p /home/appuser/code/xview-2/
RUN mkdir -p /home/appuser/submission/ 
RUN mkdir -p /home/appuser/output/ 

RUN pip3 install numpy
RUN pip3 install -U "tensorflow==1.*"
RUN pip3 install matplotlib tqdm libtiff scipy Pillow scikit-image opencv-python imgaug IPython geopandas keras imantics simplification scikit-learn chainer tensorboard tensorboardX

#ADD xview-2 /code/xview-2/
RUN git clone https://github.com/cambrio/xview2-baseline-debug.git /home/appuser/code/xview-2
RUN echo "v032 (to force hash mismatch)"

# Grabbing weights for our models
# UNCOMMENT THIS WHEN REPO/WEIGHTS ARE PUBLIC
RUN curl -L https://github.com/DIUx-xView/xView2/releases/download/v1.0/localization.h5 -o /home/appuser/code/xview-2/weights/localization.h5
RUN curl -L https://github.com/DIUx-xView/xView2/releases/download/v1.0/classification.hdf5 -o /home/appuser/code/xview-2/weights/classification.hdf5

# Finally running the container with the run.sh wrapper script to pass the CLI arguments to inference.sh
#RUN chmod +x ~/code/xview-2/submission/run.sh
RUN chmod a+x /home/appuser/code/xview-2/submission/run.sh
ENTRYPOINT ["/home/appuser/code/xview-2/submission/run.sh", "/home/appuser/code/xview-2/"]
