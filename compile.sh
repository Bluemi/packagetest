#!/bin/bash

case "$1" in
	c)
		if [ ! -d build ]; then
			mkdir build
		fi

		python3 setup.py copy_build_files

		pip install -e .
		;;
	p)
		if [ -d "dist" ]; then
			rm -rv dist
		fi
		python3 -m build
		# python3 ./setup.py
		;;
	u)
		python3 -m twine upload --repository testpypi dist/*.tar.gz
		;;
	clean)
		rm -rfv dist build src/packagetest.egg-info/
		;;
	*)
		echo "invalid option"
		;;
esac
