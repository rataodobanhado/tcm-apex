#!/bin/bash
cd /files

tar -xzf jre-8u201-linux-x64.tar.gz
mv jre1.8.0_201 /usr/local/java
echo 'JAVA_HOME=/usr/local/java' >> /etc/profile
echo 'PATH=$PATH:$HOME/bin:$JAVA_HOME/bin' >> /etc/profile
echo 'export JAVA_HOME' >> /etc/profile
echo 'export PATH' >> /etc/profile
update-alternatives --install "/usr/bin/java" "java" "/usr/local/java/bin/java" 1
source /etc/profile
