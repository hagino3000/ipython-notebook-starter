.PHONY: setup_python profile external_notebooks start

setup_python:
	pip install --upgrade distribute
	pip install --upgrade setuptools
	pip install --upgrade -r requirements.txt

external_notebooks:
	git submodule init
	git submodule update
	#find notebook_root -name '*.ipynb' -print0 | xargs -0 ./bin/ipython trust

profile:
	mkdir -p profile
	IPYTHONDIR=${CURDIR}/.ipython ipython profile create --profile-dir=${CURDIR}/profile

mathjax:
	IPYTHONDIR=${CURDIR}/.ipython ipython -c "from IPython.external import mathjax; mathjax.install_mathjax()"

start:
	IPYTHONDIR=${CURDIR}/.ipython ipython notebook --no-browser --notebook-dir=${CURDIR}/notebook_root --profile-dir=${CURDIR}/profile --profile=default
