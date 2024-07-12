#!/bin/bash

case "$1" in
	cc)
		if [ ! -d build ]; then
			mkdir build
		fi

		cmake -B build -DCMAKE_BUILD_TYPE=Release -G "Unix Makefiles"

		cd build
		make -j 6
		;;
	ci)
		rm -rfv dist
		cibuildwheel --archs auto64 --output-dir dist
		# FORCE_AVX2=1 cibuildwheel --archs auto64 --output-dir dist
		;;
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
