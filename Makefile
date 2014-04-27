
setup_python:
	virtualenv .
	./bin/pip install -r requirements.txt

external_notebooks:
	git submodule init
	git submodule update
	find notebook_root -name '*.ipynb' -print0 | xargs -0 ./bin/ipython trust

profile:
	./bin/ipython profile create

start:
	cd notebook_root;../bin/ipython notebook --ip=\* --no-browser --profile=default
