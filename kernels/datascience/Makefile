KERNEL_NAME := "data_science"
KERNEL_DESCRIPTION := "data science"


.PHONY: setup
setup:
	poetry config --local virtualenvs.in-project true
	poetry install
	./.venv/bin/python -m ipykernel install --user --name=$(KERNEL_NAME) --display-name=$(KERNEL_DESCRIPTION)

