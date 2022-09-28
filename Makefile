PIP:=./env/bin/pip
PYTHON:=./.venv/bin/python3
JUPYTER:=./.venv/bin/jupyter


.PHONY: setup
setup:
	poetry config --local virtualenvs.in-project true
	poetry install


.PHONY: ipython
ipython:
	./.venv/bin/ipython

.PHONY: start
start:
	${JUPYTER} notebook\
		--notebook-dir=${CURDIR}/notebook_root\
		--ip=0.0.0.0\
		--browser=no\

.PHONY: kernel*
kernel/list:
	${JUPYTER} kernelspec list


kernel/remove:
	${JUPYTER} kernelspec remove ${NAME}
