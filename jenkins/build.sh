#!/bin/sh

set -e

buildNo=""
type=""

# check build type
if [ -z "$1" ]
then
    echo "Use default build type 'release'"
    type=release
else
    type=$1
fi

# define build number 
if [ ${BUILD_NUMBER} ];then
    buildNo=${BUILD_NUMBER}
fi

echo "====buildNo:${buildNo}, type:${type}===="

export LANG='en_US.UTF-8'
export LC_ALL='en_US.UTF-8'
export LANGUAGE='en_US.UTF-8'

pwd

rm -rf out
#compile
./gradlew clean && ./gradlew assemble${type} -PbuildNo=${buildNo}

#outout files
mkdir out
cp app/build/outputs/apk/${type}/* out/
if [ "$type" == "release" ];then
cp app/build/outputs/mapping/release/* out/
fi

