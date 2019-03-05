tcm-apex
========

Oracle Express Edition 11g Release 2 rodando no Ubuntu 14.04.1 LTS com APEX 18.2 e ORDS 18.4.0.354.1002 no Tomcat 8 e JRE 1.8u201. 

Arquivos de timezone do Oracle atualizados para a versao 31

# Obtenha um prebuild da imagem a partir do docker hub

## Instalação:

    docker pull fnetobr/tcm-apex

#### Execute o container baseado na imagem do docker com as ports 8081 e 1521 abertas:

    docker run -d --name <nome-do-seu-container> -p 8081:8080 -p 1521:1521 fnetobr/tcm-apex    

#### Execute o container através do docker-compose
	Exemplo de arquivo __docker-compose.yml__ com portas 8081 e 1521 abertas e associação da
    pasta __/docker_files__ com a pasta __/tmp/docker_files__ do container (modificar o parâmetro 
    para o formato Windows se for o caso):
	
	db:
      image: fnetobr/tcm-apex
      container_name: <nome-do-seu-container>
    ports:
      - 1521:1521
      - 8081:8080
    volumes:
      - /docker_files:/tmp/docker_files

    Criar o arquivo docker-compose.yml como no exemplo acima em uma pasta e executar o 
    comando __docker-compose up__ a partir da linha de comando dentro da pasta.

## Senha para SYS, SYSTEM, Tomcat ADMIN e APEX ADMIN:

    __secret__

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
