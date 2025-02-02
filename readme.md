tcm-apex
========

Imagem docker do Oracle Express Edition 11g Release 2 rodando no Ubuntu 14.04.1 LTS com APEX 18.2 localizado para
português do Brasil e ORDS 18.4.0.354.1002 rodando no Tomcat 8.5.38 e JRE 1.8u201.

_Arquivos de timezone do Oracle atualizados para a versão 31_
> Baseado nos scripts de Andrzej Raczkowski <araczkowski@gmail.com>

> https://github.com/araczkowski/docker-oracle-apex-ords

# Obtenha um prebuild da imagem a partir do docker hub

    docker pull fnetobr/tcm-apex

# Construa sua própria imagem a partir do repositório github

#### Faça o download da imagem do github

    git clone --depth=1 https://github.com/rataodobanhado/tcm-apex <nome-da-sua-imagem-git>

#### Contrua sua imagem (download dos arquivos de atuaalização direto do repositório github via curl)

    docker build -t <nome-da-sua-imagem[:tag]> ./<nome-da-sua-imagem-git>

#### Contrua sua imagem a partir dos arquivos locais (mais rápido)

    docker build -t <nome-da-sua-imagem[:tag]> ./<nome-da-sua-imagem-git> --build-arg BUILD=LOCAL

# Execução do container

#### Execute o container baseado na imagem com as portas 8081 e 1521 abertas:

    docker run -d --name <nome-do-seu-container> -p 8081:8080 -p 1521:1521 <nome-da-imagem>

#### Execute o container através do docker-compose
	Exemplo de arquivo docker-compose.yml com portas 8081 e 1521 abertas e associação da
	pasta /docker_files do sistema com a pasta /tmp/docker_files do container (modificar
	o parâmetro para o formato Windows se for o caso):

	db:
      image: <nome-da-imagem>
      container_name: <nome-do-seu-container>
    ports:
      - 1521:1521
      - 8081:8080
    volumes:
      - /docker_files:/tmp/docker_files

    Crie o arquivo docker-compose.yml como no exemplo acima em uma pasta e execute o
    comando "docker-compose up" a partir da linha de comando dentro da pasta.

#### Faça uma cópia: [docker-compose.yml](https://raw.githubusercontent.com/rataodobanhado/tcm-apex/master/docker-compose.yml)


# Senha para SYS, SYSTEM, Tomcat ADMIN e APEX ADMIN:

    secret

# Conexões

#### Conecte-se ao Oracle com as seguintes credenciais:

    hostname: localhost
    porta: 1521
    sid: xe
    usuário: system
    password: secret


#### Conecte-se ao Tomcat Manager com as seguintes credenciais:

    http://localhost:8081/manager
    usuário: ADMIN
    senha: secret

#### Conecte-se ao console do Oracle Application Express pelo ORDS com as seguintes:

    http://localhost:8081/ords/apex
    workspace: INTERNAL
    usuário: ADMIN
    senha: secret
