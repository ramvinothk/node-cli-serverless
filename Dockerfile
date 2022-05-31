FROM public.ecr.aws/lambda/nodejs:16-x86_64

RUN yum update -y
RUN yum install -y wget
RUN yum groupinstall -y "Development Tools"
RUN yum -y install cmake3
RUN wget https://github.com/Kitware/CMake/releases/download/v3.18.2/cmake-3.18.2-Linux-x86_64.sh -O cmake.sh
RUN sh cmake.sh --prefix=/usr/local/ --exclude-subdir
RUN yum -y install mesa-libGL
RUN yum -y install gtk3-devel
#RUN yum -y install dbus-libs
RUN yum -y install gtk2
RUN yum -y install mesa-libGLU
RUN wget https://github.com/prusa3d/PrusaSlicer/releases/download/version_2.4.2/PrusaSlicer-2.4.2+linux-x64-GTK2-202204251127.tar.bz2
RUN tar -xf PrusaSlicer-2.4.2+linux-x64-GTK2-202204251127.tar.bz2
RUN cp PrusaSlicer-2.4.2+linux-x64-GTK2-202204251127/bin/prusa-slicer /usr/bin/
RUN prusa-slicer --help-fff

#RUN wget https://cmake.org/files/v3.12/cmake-3.12.3.tar.gz
#RUN tar zxvf cmake-3.*
#RUN cd cmake-3.*
#RUN ./bootstrap --prefix=/usr/local | bash
#RUN make -j$(nproc)
#RUN make install
#RUN curl -o- https://github.com/Kitware/CMake/releases/download/v3.23.1/cmake-3.23.1-linux-x86_64.sh | bash
#ENV NVM_DIR=/root/.nvm
#RUN . "$NVM_DIR/nvm.sh" && nvm install ${NODE_VERSION}
#RUN . "$NVM_DIR/nvm.sh" && nvm use v${NODE_VERSION}
#RUN . "$NVM_DIR/nvm.sh" && nvm alias default v${NODE_VERSION}
#ENV PATH="/root/.nvm/versions/node/v${NODE_VERSION}/bin/:${PATH}"
RUN node --version
RUN npm --version

COPY package.json ./
# Assumes your function is named "app.js", and there is a package.json file in the app directory
COPY ./app/ ./

# Install NPM dependencies for function
RUN npm install

# Set the CMD to your handler (could also be done as a parameter override outside of the Dockerfile)
CMD [ "app.handler" ]