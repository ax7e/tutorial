
Installation Steps
=====

Requirement
-----------

Apt
~~~


* python3
* python3-pip
* git
* llvm-9
* cmake
* build-essential
* make
* autoconf
* automake
* scons
* libboost-all-dev
* libgmp10-dev
* libtool
* default-jdk

Pip
~~~


* numpy
* decorator
* attrs
* tornado
* psutil
* xgboost
* cloudpickle
* tensorflow
* tqdm
* IPython
* botorch
* jinja2
* pandas
* scipy
* scikit-learn
* plotly

Sbt
~~~

.. code-block:: bash

   echo "deb https://repo.scala-sbt.org/scalasbt/debian all main" | sudo tee /etc/apt/sources.list.d/sbt.list
   echo "deb https://repo.scala-sbt.org/scalasbt/debian /" | sudo tee /etc/apt/sources.list.d/sbt_old.list
   curl -sL "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x2EE0EA64E40A89B84B2DF73499E82A75642AC823" | sudo apt-key add
   sudo apt-get update
   sudo apt-get install sbt

Git
~~~

.. code-block:: bash

   git clone --recursive -b micro_tutorial https://github.com/pku-liang/HASCO.git
   git clone --recursive -b micro_tutorial https://github.com/pku-liang/TENET.git
   git clone https://github.com/KnowingNothing/FlexTensor-Micro.git
   git clone -b demo https://github.com/pku-liang/TensorLib.git

Install
^^^^^^^
Here is a shell file :download:`code <shells/install_ahs.sh>`.

Hasco
~~~~~

.. code-block:: bash

   cd ./ HASCO
   bash ./install.sh

   # Settings
   vim ~/.bashrc
   # append:
   # export TVM_HOME=<install_dir>/HASCO/src/tvm
   # export AX_HOME=<install_dir>/HASCO/src/Ax
   # export PYTHONPATH=$TVM_HOME/python:$AX_HOME:${PYTHONPATH}
   source ~/.bashrc

TENET
~~~~~

.. code-block:: bash

   cd ./TENET
   bash ./init.sh
   vim ~/.bashrc
   # append:
   # export LD_LIBRARY_PATH=<install_dir>/TENET/external/lib:$LD_LIBRARY_PATH
   source ~/.bashrc

   cd TENET
   make cli
   make hasco

Dockerfile
^^^^^^^^^^

You can run the following Dockerfile to build a docker satisfying with all requirements.

.. code-block:: dockerfile

   # syntax=docker/dockerfile:1
   FROM ubuntu:20.04

   ENV DEBIAN_FRONTEND=noninterative

   RUN apt-get update \
       && apt-get -y -q install git sudo\
       && mkdir tutorial \
       && cd tutorial \
       && git clone --recursive -b micro_tutorial https://github.com/pku-liang/HASCO.git \
       && git clone --recursive -b micro_tutorial https://github.com/pku-liang/TENET.git \
       && git clone -b demo https://github.com/pku-liang/TensorLib.git \
       && git clone https://github.com/KnowingNothing/FlexTensor-Micro.git \
       && apt-get -y -q install vim python3 python3-pip llvm-9 cmake build-essential make autoconf automake scons libboost-all-dev libgmp10-dev libtool curl default-jdk \
       && pip3 install tensorflow decorator attrs tornado psutil xgboost cloudpickle tqdm IPython botorch jinja2 pandas scipy scikit-learn plotly \
       && echo "deb https://repo.scala-sbt.org/scalasbt/debian all main" | sudo tee /etc/apt/sources.list.d/sbt.list \
       && echo "deb https://repo.scala-sbt.org/scalasbt/debian /" | sudo tee /etc/apt/sources.list.d/sbt_old.list \
       && curl -sL "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x2EE0EA64E40A89B84B2DF73499E82A75642AC823" | sudo apt-key add \
       && sudo apt-get update \
       && sudo apt-get -y -q install sbt \
       && cd HASCO \
       && bash ./install.sh \
       && cd ../TENET \
       && bash ./init.sh \
       && cd ../TensorLib \
       && sbt compile \
       && cd ..

Run
---

HASCO
~~~~~

Config

``vim src/codesign/config.py``

.. code-block:: python

   mastro_home = "<install_dir>/HASCO/src/maestro"
   tenet_path = "<install_dir>/TENET/bin/HASCO_Interface"

   tenet_params = {
       "avg_latency":16 # average latency for each computation
       "f_trans":12 # energy consume for each element transfered
       "f_work":16 # energy consume for each element in the workload
   }

   tensorlib_home = "<install_dir>/TensorLib"
   tensorlib_main = "tensorlib.ParseJson"

Python API

.. code-block:: bash

   python3 testbench/co_mobile_conv.py
   python3 testbench/resnet_gemm.py
   ...

CLI

.. code-block:: bash

   cd HASCO
   ./hasco.py -h
   ./hasco.py -i GEMM -b MobileNetv2 -f conv_example.json -l 1000 -p 20 -a 0

Results:


* ``rst/MobileNetV2_CONV.csv``  config of best design for each constraint, view with ``column -s, -t < MobileNetV2_CONV.csv``
* ``rst/software/MobileNetV2_CONV_*`` tvm IR for each design
* ``rst/hardware/CONV_*.json`` TensorLib config for each design
* ``rst/hardware/CONV_*.v`` TensorLib generated Verilog

TENET
~~~~~

.. code-block:: bash

   cd TENET

   ./bin/tenet -h

   ./bin/tenet -p ./dataflow_example/pe_array.p -s ./dataflow_example/conv.s -m ./dataflow_example/dataflow.m -o output.csv --all

   ./bin/tenet -e ./network_example/MobileNet/config -d ./network_example -o output.csv --all

Result:\ ``output.csv``
