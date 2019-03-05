fnetobr/tcm-apex
================

Oracle Express Edition 11g Release 2 on Ubuntu 14.04.1 LTS with APEX 18.2 and ORDS 18.4.0.354.1002 on Tomcat
# Option 1. Own docker image, with custom password

#### Get the image code from github:

    git clone --depth=1 https://github.com/rataodobanhado/tcm-apex.git <own-image-name>
    cd <own-image-name>

#### Building your own image, with custom password:

    docker build -t <own-image-name> --build-arg PASSWORD=<custom-password> .

#### Run the container based on your own image with 8080, 1521, 22 ports opened:

    docker run -d --name <own-container-name> -p 49160:22 -p 8080:8080 -p 1521:1521 <own-image-name>

# Option 2. Get the prebuilt image from docker hub

#### Installation:

    docker pull fnetobr/tcm-apex

#### Run the container based on prebuilt image from docker with 8080, 1521, 22 ports opened:

    docker run -d --name <own-container-name> -p 49160:22 -p 8080:8080 -p 1521:1521 fnetobr/tcm-apex    

#### Password for SYS & SYSTEM & Tomcat ADMIN & APEX ADMIN:

        secret


# Connect to server in container (Option 1. / Option 2.)

##### Connect via ssh to server with following setting:

    ssh root@localhost -p 49160
    password: <custom-password> / secret

##### Connect database with following setting:

    hostname: localhost
    port: 1521
    sid: xe
    username: system
    password: <custom-password> / secret


##### Connect to Tomcat Manager with following settings:

    http://localhost:8080/manager
    user: ADMIN
    password: <custom-password> / secret

##### Connect to Oracle Application Express web management console via ORDS with following settings:

    http://localhost:8080/ords/apex
    workspace: INTERNAL
    user: ADMIN
    password: <custom-password> / secret
