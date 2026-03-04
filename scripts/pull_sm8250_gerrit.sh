#! /usr/bin/env bash

REFS="refs/changes/$1"
start_time=$(date +"%s")

if [ -z "$1" ]; then
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

[ ! -d $(pwd)/sm8250 ] && git clone https://github.com/LineageOS/android_kernel_qcom_sm8250.git sm8250 || echo "No need to reclone."

pushd $(pwd)/sm8250; git fetch https://github.com/LineageOS/android_kernel_qcom_sm8250 "$REFS" && git reset --hard FETCH_HEAD; popd
end_time=$(date +"%s")
tdiff=$(($end_time-$start_time))
mins=$((($tdiff % 3600) / 60))
secs=$(($tdiff % 60))
printf "Done, pulled $REFS (%02g:%02g (mm:ss))\n" $mins $secs
