#!/bin/sh -x

usage () {
  echo "usage: `basename $0` [-n name] [-v version] [-h home] [-l log] [-t tag]"
  exit 1
}

name=swookiee
version=1.0.0-SNAPSHOT
tag=`date "+%Y%m%d%H%M%S"`
dir=target
description="Swookiee"

while getopts "n:v:p:h:l:t:" option; do
  case "$option" in
    n) name="$OPTARG";;
    v) version="$OPTARG";;
    h) home="$OPTARG";;
    l) log="$OPTARG";;
    t) tag="$OPTARG";;
    :) echo "Error: -$OPTARG requires an argument"
       usage
       exit 1
       ;;
    ?) echo "Error: unknown option -$OPTARG"
       usage
       exit 1
       ;;
  esac
done

id=$name
home=${home:-/opt/$id}
log=${log:-/opt/$id/log/$id}

echo "packaging service: $id"

common="-s dir --force -t rpm -n ${name} -v ${version}\
 --architecture noarch\
 --iteration ${tag}\
 --license \"EPL\"\
 --directories=${home}
 --description=${description}"

resources="runtime=${home}\
 ../common/swookiee=/etc/init.d/swookiee\
 ../common/logback.xml=${home}/logback.xml\
 ../common/config.sample=/etc/default/swookiee"

rpm="-t rpm --rpm-os linux\
 --before-install ../rpm/before-install.sh\
 --after-install ../rpm/after-install.sh\
 --before-remove ../rpm/before-remove.sh\
 --after-remove ../rpm/after-remove.sh"

cd $dir; fpm $rpm $common $resources
