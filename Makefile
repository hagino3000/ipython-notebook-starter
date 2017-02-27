.PHONY: setup jupyter_drive nbextensions profile external_notebooks start

setup:
	pyenv local anaconda3-4.0.0
	pyenv rehash
	pip install google-api-python-client

external_notebooks:
	git submodule init
	git submodule update

nbextensions:
	pip install https://github.com/ipython-contrib/IPython-notebook-extensions/archive/master.zip

profile:
	mkdir -p .ipython
	IPYTHONDIR=${CURDIR}/.ipython ipython profile create

install_extensions:
	JUPYTER_CONFIG_DIR=${CURDIR}/.jupyter cd ${CURDIR}/extensions/RISE & python setup.py install

ipython:
	IPYTHONDIR=${CURDIR}/.ipython ipython

start:
	IPYTHONDIR=${CURDIR}/.ipython jupyter notebook\
		--notebook-dir=${CURDIR}/notebook_root\
		--browser=no\

src := INPUT_ME
convert:
	IPYTHONDIR=${CURDIR}/.ipython ipython nbconvert $(src) --to=html --profile-dir=${CURDIR}/profile

