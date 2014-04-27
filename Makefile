
install:
	virtualenv .
	./bin/pip install --use-wheel -r requirements.txt

setup: install
	git submodule init
	git submodule update

profile:
	./bin/ipython profile create

start:
	cd notebook_root;../bin/ipython notebook --ip=\* --no-browser --profile=default
