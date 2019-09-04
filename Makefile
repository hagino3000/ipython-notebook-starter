VIRTUALENV:=virtualenv
INTELMKL:=/opt/intel/mkl/lib/intel64/
PIP:=./env/bin/pip
PYTHON:=./env/bin/python3


.PHONY: setup
setup:
	${VIRTUALENV} -p /usr/local/bin/python3.7 ./env
	./env/bin/pip install pip -U
	./env/bin/pip install -r requirements.txt

.PHONY: external_notebooks
external_notebooks:
	git submodule init
	git submodule update

.PHONY: profile
profile:
	mkdir -p .ipython
	IPYTHONDIR=${CURDIR}/.ipython ./env/bin/ipython profile create

.PHONY: ipython
ipython:
	LD_LIBRARY_PATH=$(INTELMKL) IPYTHONDIR=${CURDIR}/.ipython ./env/bin/ipython

.PHONY: start
start:
	LD_LIBRARY_PATH=$(INTELMKL) IPYTHONDIR=${CURDIR}/.ipython ./env/bin/jupyter notebook\
		--notebook-dir=${CURDIR}/notebook_root\
		--ip=0.0.0.0\
		--browser=no\

.PHONY: convert
src := INPUT_ME
convert:
	IPYTHONDIR=${CURDIR}/.ipython ./env/bin/ipython nbconvert $(src) --to=html --profile-dir=${CURDIR}/profile
