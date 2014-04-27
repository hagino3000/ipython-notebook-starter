
install:
	virtualenv .
	./bin/pip install --use-wheel -r requirements.txt

profile:
	./bin/ipython profile create

start:
	cd notebook_root;../bin/ipython notebook --ip=\* --no-browser --profile=default
