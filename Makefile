VIRTUALENV:=virtualenv
INTELMKL:=/opt/intel/mkl/lib/intel64/
PIP:=./env/bin/pip
PYTHON:=./env/bin/python3

env:
	${VIRTUALENV} ./env -p python3.6

.PHONY: requirements
requirements: env
	$(PIP) install pip -U
	LD_LIBRARY_PATH=$(INTELMKL) $(PIP) install -r requirements.txt

.PHONY: enhanced/*
enhanced/numpy:
	-ln -s ${CURDIR}/.numpy-site.cfg ~/.numpy-site.cfg
	LD_LIBRARY_PATH=$(INTELMKL) $(PIP) install numpy --no-binary numpy
	LD_LIBRARY_PATH=$(INTELMKL) $(PYTHON) -c "import numpy; print(numpy.show_config())"

enhanced/scipy:
	-ln -s ${CURDIR}/.numpy-site.cfg ~/.numpy-site.cfg
	LD_LIBRARY_PATH=$(INTELMKL) $(PIP) install scipy --no-binary scipy
	LD_LIBRARY_PATH=$(INTELMKL) $(PYTHON) -c "import scipy; print(scipy.show_config())"

enhanced/lightgbm:
	$(PIP) install lightgbm --install-option=--gpu

.PHONY: external_notebooks
external_notebooks:
	git submodule init
	git submodule update

.PHONY: profilek
profile:
	mkdir -p .ipython
	IPYTHONDIR=${CURDIR}/.ipython ./env/bin/ipython profile create

.PHONY: ipython
ipython:
	IPYTHONDIR=${CURDIR}/.ipython ./env/bin/ipython

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
