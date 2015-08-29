.PHONY: setup profile external_notebooks start

setup:
	pip install --upgrade distribute
	pip install --upgrade setuptools
	pip install --upgrade -r requirements.txt

external_notebooks:
	git submodule init
	git submodule update

profile:
	mkdir -p .ipython
	IPYTHONDIR=${CURDIR}/.ipython ipython profile create
	-IPYTHONDIR=${CURDIR}/.ipython ipython -c "from IPython.external import mathjax; mathjax.install_mathjax()"

ipython:
	IPYTHONDIR=${CURDIR}/.ipython ipython

start:
	IPYTHONDIR=${CURDIR}/.ipython jupyter-notebook\
		--notebook-dir=${CURDIR}/notebook_root\
		--browser=no\
		--config=${CURDIR}/.jupyter/jupyter_notebook_config.py

src := INPUT_ME
convert:
	IPYTHONDIR=${CURDIR}/.ipython ipython nbconvert $(src) --to=html --profile-dir=${CURDIR}/profile

