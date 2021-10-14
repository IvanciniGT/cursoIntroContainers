# Contenedor

Un entorno aislado donde ejecutar procesos dentro de un sistema operativo LINUX
    Los procesos que corren dentro de ese entorno:
        Su propia configuración de RED, independiente del host
        Limitación en cuanto al uso de Recursos HW
        Su propio sistema de archivos
Los contenedores se crean desde Imágenes de contenedor (QUE TAMBIEN ESTAN ESTANDARIZADAS)
    Es un fichero ZIP que contiene un software ya instalado / configurado + configuraciones parametrizables
    El repo mas conocido : Docker hub

------------------------------------------------------------------------------------------------------------------------------
Tipos de Software
- Aplicación        Un proceso que se ejecuta en primer plano    y para interactuar con un usuario   y que se ejcuta de forma indefinida en el tiempo
---------------------------------------------- CONTENEDORIZABLE VVVV
- Servicio          Un proceso que se ejecuta en segundo plano   y para interactuar con programas    y que se ejcuta de forma indefinida en el tiempo
- Demonio           Un proceso que se ejecuta en segundo plano   y que se ejcuta de forma indefinida en el tiempo
- Script            Un proceso que se ejecuta            y lo hace de forma finita en el tiempo... hace sus cosas (tareas) y acaba
------------------------------------------------------------------------------------------------------------------------------------------
...
Driver
SO
------------------------------------------------------------------------------------------------------------------------------

UNIX®
    Era un Sistema Operativo
    Windows10, Windows11
    Que es? Es una especificación (POSIX + SUS)
        AIX - IBM
        Solaris - Oracle (Sun microsystems)
        HP-UX - HP
        MacOS - Apple
    
    Basado en la spec UNIX, pero no certificado:
        BSD -> 386BSD -> FreeBSD , MacOS
        GNU -> GNU is Not UNIX
                    No valieron para montar un Kernel
        Linus Towalds < Linus' Unix < Linux
            GNU/Linux  (70%-30%)
                -> Debian > Ubuntu
                -> Redhat > RHEL
                            CentOS
                            Fedora
                            OracleLinux
                -> Suse
    
    Android
    
Docker Desktop For Windows
Docker Desktop For Mac

-----------------------------------------------------------------------------------------------

PROCEDIMIENTOS DE INSTALACION DE SOFTWARE 

APP1 APP2
---------
    SO
---------
  HIERRO
  
Inconvenientes: Privacidad de la información entre procesos
                Incompatibilidades entre librerias
                Falta de estabilidad: Si una app APP1 falla (CPU 100%)-> APP1 no responde
                                                                         APP2 no responde

APP1| APP2
---------
SO  | SO
---------
MV1 | MV2
---------
hipervisor    VMWARE, HyperV, Citrix, KVM
---------
    SO
---------
  HIERRO
  
Inconvenientes: Se me complican las instalaciones / mantenimiento de sistemas
                Licencias
                Más consumo de recursos (desperdicio de recursos)
                
Contenedores:

APP1| APP2
---------
C1  | C2
---------
ejecutor de contenedores / gestor de contenedores   
    runc                        crio - containerd - docker - podman
---------
SO Linux
---------
  HIERRO
 
 
 
Docker < 2013      >>>>>>    ESTANDARIZAR el concepto de contenedor
    - Había la necesidad de usar contenedores
    - La gente de Docker lo hace muy bien !!!!
        < AWS
        < Microsoft
        < RedHat


chroot

/         ROOT  
/bin
/lib
/home
    /usuario1
        /nuevoRoot
/tmp
/opt
/var

LinuxContainers
LMCTFU


-------------------------------------------------------------------
Met. Agiles de desarrollo de software? SCRUM , XtremeProgramming
    Punto 1: Nuestra mayor prioridad es satisfacer al cliente mediante la entrega temprana y CONTINUA de software con valor
        Entregar al cliente cada 2semanas-2meses
            Sprints
            ------------------------------------------------ PRODUCCION 
            Entrega 1 ->  5% funcionalidad del sistema: 100%
            Entrega 2 -> 15% funcionalidad del sistema: 100%
            Entrega 3 -> 20% funcionalidad del sistema: 100%
Met. Cascada (Waterfal)
    Requisitos > Diseño > Desarrollo > Pruebas > Documentacion > Implantación
        Diagramas de gantt
-------------------------------------------------------------------
DEV--->OPS - Cultura de la AUTOMATIZACION
    Herramientas de software que me ayudan a automatizar:
        Scripts bash
        Python
        Ansible < Puppet, Chef
        Maven   < Automatizar empaquetados y gestión de dependencias de apps JAVA
        Selenium < Automatizar tareas dentro de un nagevador de internete (Pruebas software)
        
        Perfil Devops:
            Jenkins < Servidor de CI/CD     Travis, Bamboo, TeamCity, Gitlab CI/CD
            Kubernetes/Docker/Openshift




Intrgración Continua    CI
Entrega Continua        CD
Despliegue Continuo     CD


Automatizar cómo instalo/opero/administro/distribuyo las apps de software 
    < Estandarizarlo - Contenedores (DOCKER)
    
-----------------------------------------
CLIENTE DE DOCKER
$ docker <TIPO-DE-OBJETO> <OPERACION> [<ARGUMENTOS>]
-----------------------------------------
Imagénes de contenedor   ----- image

docker image list [-q]              <    docker images
docker image rm 094248252696        <    docker rmi
docker image pull REPO:tag          <    docker pull
-----------------------------------------
CONTENEDORES             ----- container

docker container list                   <    docker ps       Contenedores en ejecución  -  Todos: -a --all
docker container rm 094248252696        <    docker rm
docker container create REPO:tag                        <<<<< Lo unico que ha hecho es crear una carpeta 
                       ^^^ARGS:
                            --name -n < NOMBRE DEL CONTENEDOR
docker container start                 < docker start
docker container restart               < docker restart
docker container stop                  < docker stop
docker container inspect               < docker inspect
docker container logs                  < docker logs
-----------------------------------------


docker engine
    DockerD
    Cli - docker



IMAGEN DE CONTENEDOR: httpd:latest
    Archivo comprimido... que cuando se descomprime (Ya se ha hecho) da lugar a:
        Una carpeta dentro de /var/lib/docker/images
                (de alguna forma... aqui habrá una instalación del serv web apache)
            /etc/apache                     < Configuracion
                        /httpd.conf
            /opt/apache                     < Ejecutables
                        httpd
            /opt/apache/www                 < Pagina web por defecto
             
             Además se van a montar todas las librerias y programas que el desarrollador haya querido meter dentro de la imagen
                Practicamente SIEMPRE un desarrollador va a partir de una imagen base de SO Linux.
             
             
IMAGEN DE FEDORA:   Proyecto upstream de RHEL         REDHAT            Distro de Linux
    Kernel de fedora - 62 Mbs?  Ni de coña
    Distro completa  - 62 Mbs?  Ni de coña
    SO Virtualizado  - 62 Mbs?  Ni de coña
    
    Las librerias que se montan por encima del kernel de Linux
        yum
        ls
        mkdir
        rm
        bash
             
UBUNTU
    Las librerias que se montan por encima del kernel de Linux
        apt   apt-get
        ls
        mkdir
        rm
        bash
             
             
---------------------
Cuantos interfaces de red tenemos en la maquina:
- eth   - Tarjeta de red física 
- loopback (localhost) 127.0.0.1 ... Que es esto? Es una red física? No, lógica, que existe dentro del host
- docker
HOST: 
    loopback                127.0.0.1
    ens5                    172.31.15.132
    docker0                 172.17.0.1

    APACHE HTTPD: dentro de un contenedor:        Servidor WEB > Proxy reverso
            miapache:       172.17.0.2
           NGINX                                  Proxy reverso > Servidor WEB
           
docker <<< Herramienta de andar por casa... cutrecilla      DESARROLLADOR PARA SU ENTORNO 
    kubernetes & Openshift
        Openshift es una distro de Kubernetes que fabrica REDHAT
            REDHAT = Opensource: Todo el mundo ve el código              y gratis? NO     eso es freeware
            
                Linux:
                    RHEL      -        Fedora (Upstream de RHEL)       ---> CentOS (Vieja de RHEL)
                App Server :
                    JBOSS     -        WildFly
                Ansible engine      -    Ansible proyect
                Ansible Tower       -    AWX
                Openshift Container Platform   -   Openshift Origin (upstream)
                    
        
        
---------        

HTTPD:
    /etc/httpd.conf
    /opt/apache/httpd
    /bin/ls
    /bin/mkdir
    
HOST:
    /
        bin
        etc
        lib
        opt
        var
            /lib
                /docker
                    /container
                        .... /miapache
                                CUALQUIER CAMBIO QUE SE REALICE EN EL SISTEMAS DE ARCHIVOS DE UN CONTENEDOR VIENE AQUI
                                saluda.txt
                    /image
                            INALTERABLE
                        .... /httpd    <<<<<<<<<<<<<<<<<<<   Este va a ser el directorio raiz del contenedor   --- chroot
                                /home
                                /tmp
                                /var
                                /boot
                                /bin/ls
                                /bin/mkdir
                                /bin/bash
                                /usr/local/apache2
        home
        tmp
    
El sistema de archivos de un contenedor esta formado por varias capas SUPERPUESTAS
    VVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVV
CAPA n: VOLUMENES   mount 
    /datos ----> /home/ubuntu/environment/datos del host
CAPA 1: Capa del contenedor:

CAPA 0 - Capa de la imagen del contenedor
    /home     /usr          /var    /lib    /bin        /tmp
                /local
                  /apache2
                  
                  
El log de un contenedor es la salida estandar el stdout del proceso 1 que corre en el contenedor


BBDD ---> Los datos los guarda en ficheros... en el FileSystem

MySQL 5.7
MySQL 5.7.1


Docker - GUAY para ejecutar contenedores en mi ordenador

ENTORNO PRODUCCION:
- Alta disponibilidad / HA   <<<<   €€€€€€€€€€€€    
- Escalabilidad              <<<<   €€€€€€€€€€€€

- Seguridad <<<< Lo deberian de tener todos los entornos


Escalabilidad:
    Capacidad de ajustar los recursos de HW a las necesidades actuales del sistema
    
App1:
    Dia 1:      100
    Dia 10:    1000
    Dia 100:   5000
    Dia 1000: 10000

App2:   ESTE EL MUNDO DE HOY EN DIA - INTERNET              APP Emergencias
    Dia n:        100                                               0
    Dia n+1:   100000   Black Friday                            5.000.000
    Dia n+2:     5000                                               0
    Dia n+3:  1000000   Ciber Monday
    
Cloud < Alquilar máquinas bajo demanda
cluster 10 servidores    --- 20 servidores    - 5 servidores  --- 500 servidores  - 3 servidores      <<< Openshift

                                    Sistema de almacenamiento externo: SAN LAN Cloud 
Servidor 1
    App1- MySQL
Servidor 2   PUF !!!!!!
    
Servidor 3
    App1- MySQL
