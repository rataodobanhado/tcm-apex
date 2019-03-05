#!/bin/bash

mkdir /files && cd files

downloadFiles () {

	local url="https://github.com/rataodobanhado/tcm-apex"

	local files=(
    oracle-xe_11.2.0-1.0_amd64.debaa
    oracle-xe_11.2.0-1.0_amd64.debab
    oracle-xe_11.2.0-1.0_amd64.debac
	  timezlrg_31.dat
  	timezone_31.dat
    apex_18.2.zip.part-aa
    apex_18.2.zip.part-aa
    apex_18.2.zip.part-aa
    ords-18.4.0.354.1002.zip
		tomcat-8.0.11.tar.gz
    jre-8u201-linux-x64.tar.gz
	)

	local i=1
	for part in "${files[@]}"; do
		echo "[Downloading '$part' (part $i/11)]"
		curl --progress-bar --retry 3 -m 60 -o $part -L $url/blob/master/files/$part?raw=true
		i=$((i + 1))
	done
}

downloadFiles
