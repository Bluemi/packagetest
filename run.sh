#!/bin/bash

DATA_PATH="/run/media/alok/SanDiskBruno/DEG"

case "$1" in
	t)
		python3 tests/cpp_test.py "$DATA_PATH"
		;;
	rt)
		pytest
		;;
	a|anns)
		python3 tests/bench_anns.py "$DATA_PATH"
		;;
	b|build)
		python3 tests/bench_build.py "$DATA_PATH"
		;;
	e|explore)
		python3 tests/bench_explore.py "$DATA_PATH"
		;;
	*)
		echo "unknown option"
		;;
esac
