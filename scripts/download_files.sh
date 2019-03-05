#!/bin/bash

mkdir /files && cd files

downloadFiles () {

	local url="https://github.com/araczkowski/docker-oracle-apex-ords"

	local files=(
    oracle-xe_11.2.0-1.0_amd64.debaa
    oracle-xe_11.2.0-1.0_amd64.debab
    oracle-xe_11.2.0-1.0_amd64.debac
    oracle-xe_11.2.0-1.0_amd64.debad
    oracle-xe_11.2.0-1.0_amd64.debae
    oracle-xe_11.2.0-1.0_amd64.debaf
    oracle-xe_11.2.0-1.0_amd64.debag
    oracle-xe_11.2.0-1.0_amd64.debah
    oracle-xe_11.2.0-1.0_amd64.debai
    oracle-xe_11.2.0-1.0_amd64.debaj
    oracle-xe_11.2.0-1.0_amd64.debak
    oracle-xe_11.2.0-1.0_amd64.debal
    oracle-xe_11.2.0-1.0_amd64.debam
    oracle-xe_11.2.0-1.0_amd64.deban
    oracle-xe_11.2.0-1.0_amd64.debao
    oracle-xe_11.2.0-1.0_amd64.debap
    oracle-xe_11.2.0-1.0_amd64.debaq
    oracle-xe_11.2.0-1.0_amd64.debar
	  timezlrg_31.dat
  	timezone_31.dat
#    apex_5.1.1_en.zip
#    apex_18.2.zip
    apex_18.2.zip.part-aa
    apex_18.2.zip.part-aa
    apex_18.2.zip.part-aa
#    ords.3.0.9.348.07.16.zip
    ords-18.4.0.354.1002.zip
		tomcat-8.0.11.tar.gz
#		jre-7u79-linux-x64.tar.gz
    jre-8u201-linux-x64.tar.gz
	)

	local i=1
	for part in "${files[@]}"; do
		echo "[Downloading '$part' (part $i/26)]"
		curl --progress-bar --retry 3 -m 60 -o $part -L $url/blob/master/files/$part?raw=true
		i=$((i + 1))
	done
}

downloadFiles
