#! /usr/bin/env bash

REFS="$1"
local start_time=$(date +"%s")

if [ -z "$REFS" ]; then
	echo "Specify the refs!"
	exit 1;
fi

if [ -d $(pwd)/sm8250 ]; then
	echo "Detected $(pwd)/sm8250, pulling from github.."
	pushd $(pwd)/sm8250
	git config pull.rebase true
	git pull origin lineage-20
	popd
fi

echo "To be pulled: $REFS"

git clone https://github.com/LineageOS/android_kernel_qcom_sm8250.git sm8250
pushd $(pwd)/sm8250; git fetch https://github.com/LineageOS/android_kernel_qcom_sm8250 "$REFS" && git reset --hard FETCH_HEAD; popd

local end_time=$(date +"%s")
local tdiff=$(($end_time-$start_time))
local mins=$((($tdiff % 3600) / 60))
local secs=$(($tdiff % 60))

printf "Done, pulled $REFS (%02g:%02g (mm:ss))\n" $mins $secs
