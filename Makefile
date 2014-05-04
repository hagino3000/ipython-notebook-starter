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
	ipython profile create --profile-dir=${CURDIR}/profile

start:
	ipython notebook --no-browser --notebook-dir=${CURDIR}/notebook_root --profile-dir=${CURDIR}/profile --profile=default
