
setup_python:
	pip install --upgrade distribute
	pip install --upgrade setuptools
	pip install --upgrade -r requirements.txt

external_notebooks:
	git submodule init
	git submodule update
	#find notebook_root -name '*.ipynb' -print0 | xargs -0 ./bin/ipython trust

profile:
	ipython profile create

start:
	cd notebook_root;ipython notebook --ip=\* --no-browser --profile=default
