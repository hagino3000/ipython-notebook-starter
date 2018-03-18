
VIRTUALENV:=/usr/local/bin/virtualenv
INTELMKL:=/opt/intel/mkl/lib/intel64/

env:
	${VIRTUALENV} ./env

.PHONY: requirements
requirements: env
	./env/bin/pip install pip -U
	LD_LIBRARY_PATH=$(INTELMKL) ./env/bin/pip install -r requirements.txt

.PHONY: external_notebooks
external_notebooks:
	git submodule init
	git submodule update

.PHONY: profilek
profile:
	mkdir -p .ipython
	IPYTHONDIR=${CURDIR}/.ipython ./env/bin/ipython profile create

.PHONY: mkl/*
mkl/numpy:
	-ln -s ${CURDIR}/.numpy-site.cfg ~/.numpy-site.cfg
	LD_LIBRARY_PATH=$(INTELMKL) ./env/bin/pip install numpy --no-binary numpy
	LD_LIBRARY_PATH=$(INTELMKL) ./env/bin/python -c "import numpy; print(numpy.show_config())"

mkl/scipy:
	-ln -s ${CURDIR}/.numpy-site.cfg ~/.numpy-site.cfg
	LD_LIBRARY_PATH=$(INTELMKL) ./env/bin/pip install scipy --no-binary scipy
	LD_LIBRARY_PATH=$(INTELMKL) ./env/bin/python -c "import scipy; print(scipy.show_config())"

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
