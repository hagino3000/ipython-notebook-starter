.PHONY: system*
system/init:
	sudo apt-get install software-properties-common
	apt-get update-

system/upgrade:
	apt-get update
	apt-get upgrade


.PHONY: package*
package/common:
	apt-get install -y zsh
	apt-get install -y language-pack-ja-base
	apt-get install -y tmux
	apt-get install -y autojump
	apt-get install -y git
	apt-get install -y nginx
	apt-get install -y silversearcher-ag tree
	apt-get install -y curl wget
	apt-get install -y ncurses-dev lua5.2 lua5.2-dev luajit
	apt-get install -y htop iotop

package/python:
	add-apt-repository ppa:jonathonf/python-3.6
	apt-get update
	apt-get install -y python3.6
	apt-get install -y python3.6-dev
	wget https://bootstrap.pypa.io/get-pip.py
	python3.6 ./get-pip.py

package/math:
	apt-get install -y gfortran
	apt-get install -y libatlas-base-dev
	apt-get install -y libatlas-doc
	apt-get install -y libopenblas-base
	apt-get install -y libopenblas-dev

.PHONY: user*
user/tools:
	pip3 install --upgrade pip
	pip3 install percol
	pip3 install httpie
	pip3 install pipenv
	pip3 install virtualenv


jupyter/install:
	mkdir -p ./env
	virtualenv ./env -p /usr/bin/python3.6
	./env/bin/pip install -r ./requirements.txt --no-binary numpy

INTELMKL=/opt/intel/mkl/lib/intel64
jupyter/start:
	LD_LIBRARY_PATH=${INTELMKL} IPYTHONDIR=${CURDIR}/.ipython ./env/bin/jupyter notebook --notebook-dir=${CURDIR}/notebook_root --port=8888 --ip=* --certfile=mycert.pem --keyfile mykey.key














