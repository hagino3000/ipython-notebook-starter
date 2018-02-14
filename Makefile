.PHONY: setup nbextensions profile external_notebooks start

VIRTUALENV=/usr/local/bin/virtualenv
INTELMKL=/opt/intel/mkl/lib

setup:
	${VIRTUALENV} ./env
	./env/bin/pip install pip -U
	./env/bin/pip install -r requirements.txt

external_notebooks:
	git submodule init
	git submodule update

nbextensions:
	./env/bin/pip install https://github.com/ipython-contrib/IPython-notebook-extensions/archive/master.zip

profile:
	mkdir -p .ipython
	IPYTHONDIR=${CURDIR}/.ipython ./env/bin/ipython profile create

install_extensions:
	JUPYTER_CONFIG_DIR=${CURDIR}/.jupyter cd ${CURDIR}/extensions/RISE & python setup.py install

numpy_with_mkl:
	-ln -s ${CURDIR}/.numpy-site.cfg ~/.numpy-site.cfg
	LD_LIBRARY_PATH=$(INTELMKL) ./env/bin/pip install numpy --no-binary numpy
	LD_LIBRARY_PATH=$(INTELMKL) python -c "import numpy; print(numpy.show_config())"

ipython:
	IPYTHONDIR=${CURDIR}/.ipython ./env/bin/ipython

start:
	IPYTHONDIR=${CURDIR}/.ipython ./env/bin/jupyter notebook\
		--notebook-dir=${CURDIR}/notebook_root\
		--browser=no\

src := INPUT_ME
convert:
	IPYTHONDIR=${CURDIR}/.ipython ./env/bin/ipython nbconvert $(src) --to=html --profile-dir=${CURDIR}/profile
