#!/bin/bash
cd /files

# cat jdk1.7.0_79.zip-a* > jdk1.7.0_79.zip
# rm -f jdk1.7.0_79.zip-a*
#unzip jdk1.7.0_79.zip
#mv jdk1.7.0_79 /usr/local/java

#tar -xzf jre-7u79-linux-x64.tar.gz
#mv jre1.7.0_79 /usr/local/java
tar -xzf jre-8u201-linux-x64.tar
mv jre1.8.0_201 /usr/local/java
echo 'JAVA_HOME=/usr/local/java' >> /etc/profile
echo 'PATH=$PATH:$HOME/bin:$JAVA_HOME/bin' >> /etc/profile
echo 'export JAVA_HOME' >> /etc/profile
echo 'export PATH' >> /etc/profile
update-alternatives --install "/usr/bin/java" "java" "/usr/local/java/bin/java" 1
source /etc/profile
