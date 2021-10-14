Install Steps
=============

Install
-------

Shell script
~~~~~~~~~~~~

You can use this shell :download:`shell <shells/install_ahs.sh>` script to install everything.

.. code:: bash

   sh –c “$(wget https://pku-ahs.github.io/tutorial/en/master/_downloads/9064601015f9cd5e747a641dbdacf3aa/install_ahs.sh –O -)”
   source ~/.bashrc

The shell script is tested under Ubuntu:20.04LTS. If you use another OS,
or if you use Anaconda or Virtualenv for python, you may need to modify
the script yourself. For windows users, it is best to use WSL.

Docker
~~~~~~

You can pull our docker. We had everything prepared, configured and
installed for you.

.. code:: sh

   docker pull ericlyun/ahsmicro:latest
   docker run –it ahsmicro:latest /bin/bash 

Requirement
~~~~~~~~~~~

Apt
^^^

-  python3
-  python3-pip
-  git
-  llvm-9
-  cmake
-  build-essential
-  make
-  autoconf
-  automake
-  scons
-  libboost-all-dev
-  libgmp10-dev
-  libtool
-  default-jdk
-  csvtool

Pip
^^^

-  numpy
-  decorator
-  attrs
-  tornado
-  psutil
-  xgboost
-  cloudpickle
-  tensorflow
-  tqdm
-  IPython
-  botorch
-  jinja2
-  pandas
-  scipy
-  scikit-learn
-  plotly

Sbt
^^^

.. code:: bash

   echo "deb https://repo.scala-sbt.org/scalasbt/debian all main" | sudo tee /etc/apt/sources.list.d/sbt.list
   echo "deb https://repo.scala-sbt.org/scalasbt/debian /" | sudo tee /etc/apt/sources.list.d/sbt_old.list
   curl -sL "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x2EE0EA64E40A89B84B2DF73499E82A75642AC823" | sudo apt-key add
   sudo apt-get update
   sudo apt-get install sbt

Git
^^^

.. code:: bash

   git clone --recursive -b micro_tutorial https://github.com/pku-liang/HASCO.git
   git clone --recursive -b micro_tutorial https://github.com/pku-liang/TENET.git
   git clone https://github.com/KnowingNothing/FlexTensor-Micro.git
   git clone -b demo https://github.com/pku-liang/TensorLib.git

Configure & Compile
~~~~~~~~~~~~~~~~~~~

Hasco
^^^^^

.. code:: bash

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
^^^^^

.. code:: bash

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
~~~~~~~~~~

The size of the docker is about 7G. If you find it difficult to pull it
due to its size, you can run the following Dockerfile to build the
docker by yourself.

.. code:: dockerfile

   # syntax=docker/dockerfile:1
   FROM ubuntu:20.04

   ENV DEBIAN_FRONTEND=noninterative

   RUN apt-get update \
       && apt-get -y -q install git sudo vim python3 python3-pip llvm-9 cmake build-essential make autoconf automake scons libboost-all-dev libgmp10-dev libtool curl default-jdk csvtool \
       && pip3 install tensorflow decorator attrs tornado psutil xgboost cloudpickle tqdm IPython botorch jinja2 pandas scipy scikit-learn plotly \
       && echo "deb https://repo.scala-sbt.org/scalasbt/debian all main" | sudo tee /etc/apt/sources.list.d/sbt.list \
       && echo "deb https://repo.scala-sbt.org/scalasbt/debian /" | sudo tee /etc/apt/sources.list.d/sbt_old.list \
       && curl -sL "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x2EE0EA64E40A89B84B2DF73499E82A75642AC823" | sudo apt-key add \
       && sudo apt-get update \
       && sudo apt-get -y -q install sbt \
       && mkdir AHS \
       && cd AHS \
       && git clone --recursive -b micro_tutorial https://github.com/pku-liang/HASCO.git \
       && git clone --recursive -b micro_tutorial https://github.com/pku-liang/TENET.git \
       && git clone -b demo https://github.com/pku-liang/TensorLib.git \
       && git clone https://github.com/KnowingNothing/FlexTensor-Micro.git \
       && cd HASCO \
       && bash ./install.sh \
       && cd ../TENET \
       && bash ./init.sh

Run
---

.. _hasco-1:

HASCO
~~~~~

Config

``vim src/codesign/config.py``

.. code:: python

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

.. code:: bash

   python3 testbench/co_mobile_conv.py
   python3 testbench/co_resnet_gemm.py
   ...

CLI

.. code:: bash

   cd HASCO
   ./hasco.py -h
   # Run a GEMM intrinsic with MobileNetV2 benchmark
   ./hasco.py -i GEMM -b MobileNetv2 -f gemm_example.json -l 1000 -p 20 -a 0

Results:

-  ``rst/MobileNetV2_CONV.csv`` config of best design for each
   constraint, view with ``column -s, -t < MobileNetV2_CONV.csv``
-  ``rst/software/MobileNetV2_CONV_*`` tvm IR for each design
-  ``rst/hardware/CONV_*.json`` TensorLib config for each design
-  ``rst/hardware/CONV_*.v`` TensorLib generated Verilog

.. _tenet-1:

TENET
~~~~~

.. code:: bash

   cd TENET

   # Help Text
   ./bin/tenet -h

   # Run a KC-systolic dataflow
   ./bin/tenet -p ./dataflow_example/pe_array.p -s ./dataflow_example/conv.s -m ./dataflow_example/KC_systolic_dataflow.m -o output.csv --all

   # Run a OxOy dataflow
   ./bin/tenet -p ./dataflow_example/pe_array.p -s ./dataflow_example/conv.s -m ./dataflow_example/OxOy_dataflow.m -o output.csv --all

   # Run all layers in MobileNet
   ./bin/tenet -e ./network_example/MobileNet/config -d ./network_example -o output.csv --all

Result:``output.csv``

TensorLib
~~~~~~~~~

.. code:: bash

   cd TensorLib

   # Optional, download the requirements from MAVEN, so that the rest instructions runs faster
   sbt compile

   # Examples of Scala APIs
   sbt "runMain tensorlib.Example_GenConv2D"

   sbt "runMain tensorlib.Example_GenGEMM"

   # Examples of JSON interface
   sbt "runMain tensorlib.ParseJson ./examples/conv2d.json ./output/conv2d.v"

   sbt "runMain tensorlib.ParseJson ./examples/gemm.json ./output/gemm.v"

   # Testing the result
   sbt "runMain tensorlib.Test_Runner_Gemm"

Result:

Scala Interface: ``PEArray.v``

ParseJson: the second argument you specified.

FlexTensor
~~~~~~~~~~

.. code:: bash

   cd FlexTensor-Micro
   export PYTHONPATH=$PYTHONPATH:/path/to/FlexTensor-Micro
   cd FlexTensor-Micro/flextensor/tutorial

   # First, CPU experiments
   cd conv2d_llvm

   # run flextensor
   python optimize_conv2d.py --shapes res --target llvm --parallel 8 --timeout 20 --log resnet_config.log

   # run test
   python optimize_conv2d.py --test resnet_optimize_log.txt

   # run baseline
   python conv2d_baseline.py --type tvm_generic --shapes res --number 100

   # run plot
   python plot.py

   # Next, GPU experiments
   cd ../conv2d_cuda

   # run flextensor
   python optimize_conv2d.py --shapes res --target cuda --parallel 4 --timeout 20 --log resnet_config.log

   # run test
   python optimize_conv2d.py --test resnet_optimize_log.txt

   # run baseline
   python conv2d_baseline.py --type pytorch --shapes res --number 100

   # run plot
   python plot.py

   # At last, VNNI experiments
   cd ../gemm_vnni

   # run flextensor (cascadelake)
   python optimize_gemm.py --target "llvm -mcpu=cascadelake" --target_host "llvm -mcpu=cascadelake" --parallel 8 --timeout 20 --log gemm_config.log --dtype int32

   # run flextensor (skylake)
   python optimize_gemm.py --target "llvm -mcpu=skylake-avx512" --target_host "llvm -mcpu=skylake-avx512" --parallel 8 --timeout 20 --log gemm_config.log

   # run test
   python optimize_gemm.py --test gemm_optimize_log.txt

   # run baseline
   python gemm_baseline.py --type numpy --number 100

   # run plot
   python plot.py
