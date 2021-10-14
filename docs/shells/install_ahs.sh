#!/bin/bash

apt-get update 
apt-get -y -q install sudo git vim python3 python3-pip llvm-9 cmake build-essential make autoconf automake scons libboost-all-dev libgmp10-dev libtool curl default-jdk csvtool
pip3 install tensorflow decorator attrs tornado psutil xgboost cloudpickle tqdm IPython botorch jinja2 pandas scipy scikit-learn plotly 
echo "deb https://repo.scala-sbt.org/scalasbt/debian all main" | sudo tee /etc/apt/sources.list.d/sbt.list 
echo "deb https://repo.scala-sbt.org/scalasbt/debian /" | sudo tee /etc/apt/sources.list.d/sbt_old.list 
curl -sL "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x2EE0EA64E40A89B84B2DF73499E82A75642AC823" | sudo apt-key add 
sudo apt-get update 
sudo apt-get -y -q install sbt 
mkdir AHS 
cd AHS 
git clone --recursive -b micro_tutorial https://github.com/pku-liang/HASCO.git 
git clone --recursive -b micro_tutorial https://github.com/pku-liang/TENET.git 
git clone -b demo https://github.com/pku-liang/TensorLib.git 
git clone https://github.com/KnowingNothing/FlexTensor-Micro.git 
cd HASCO
bash ./install.sh
cd ../TENET
bash ./init.sh

