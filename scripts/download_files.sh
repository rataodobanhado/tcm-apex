#!/bin/bash

mkdir /files && cd files

downloadFiles () {

	local url="https://github.com/rataodobanhado/tcm-apex"

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
	  timezlrg_31.dat
  	timezone_31.dat
    apex_18.2.zipaa
    apex_18.2.zipab
    apex_18.2.zipac
    apex_18.2.zipad
    apex_18.2.zipae
    apex_18.2.zipaf
    ords-18.4.0.354.1002.zipaa
    ords-18.4.0.354.1002.zipab
    ords-18.4.0.354.1002.zipac
		tomcat-8.0.11.tar.gz
		jre-8u201-linux-x64.tar.gzaa
		jre-8u201-linux-x64.tar.gzaa
		jre-8u201-linux-x64.tar.gzaa
		jre-8u201-linux-x64.tar.gzaa
	)

	local i=1
	for part in "${files[@]}"; do
		echo "[Downloading '$part' (part $i/27)]"
 		curl --progress-bar --retry 3 -m 120 -o $part -L $url/blob/master/files/$part?raw=true
		echo < file $part 
		i=$((i + 1))
	done
}

downloadFiles
