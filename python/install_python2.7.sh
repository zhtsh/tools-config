#!/bin/bash

# update yum packages
yum -y update
yum groupinstall -y 'development tools'
yum install -y zlib-devel bzip2-devel openssl-devel xz-libs wget

# install python2.7
wget http://www.python.org/ftp/python/2.7.8/Python-2.7.8.tar.xz
xz -d Python-2.7.8.tar.xz
tar -xvf Python-2.7.8.tar
cd Python-2.7.8
./configure --prefix=/usr/local --enable-loadable-sqlite-extensions
make
make install

# make python soft link 
sed -i '$a export PATH="/usr/local/bin:$PATH"' /etc/bashrc
mv /usr/bin/python /usr/bin/python2.6
ln -s /usr/local/bin/python2.7  /usr/bin/python

# install setuptools
cd ..
wget --no-check-certificate https://pypi.python.org/packages/source/s/setuptools/setuptools-1.4.2.tar.gz
tar -xvf setuptools-1.4.2.tar.gz
cd setuptools-1.4.2
python setup.py install

# install pip 
curl  https://bootstrap.pypa.io/get-pip.py | python2.7 -

# modify yum python version
sed -i 's,#!/usr/bin/python,#!/usr/bin/python2.6,g' /usr/bin/yum
