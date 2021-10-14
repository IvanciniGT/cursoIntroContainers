# Contenedor

En entorno aislado donde ejecutar procesos dentro de un SO Linux.
    Esos procesos: 
        Tienen su propia conf de red
        Su propio sistema de almacenamiento
        Limitación de acceso a recursos HW
        Sus propias variables de entorno

Los contenedores se crean desde una IMAGEN DE CONTENEDOR:
    Un fichero comprimido que incluía:
        - Software que quiero utilizar, pero ya instalado y configurada, aunque parametrizable
    Una configuración:
        - El comando que se debe ejecutar cuyando se solicita el inicio de un contenedor
        - Paths de Volumenes útiles
        - La carpeta por defecto en la que se opera en el contenedor
        - Unas determinadas variables de entorno con unos valores por defecto
    
    Las imagenes las sacamos de un repo de imágenes (como docker hub)
----
# Volumenes
    Tener persistencia de los cambios que hagamos en el FS del contenedor, que sobreviva a la eliminación del contenedor.
    
# Redes
    Cuando instalamos docker se genera una red lógica dentro de nuestra máquina
    Al crear contenedores se les asignan IPs de esa red.
-------------
# Docker
    Demonio -> dockerd          systemctl status docker 
    Cliente -> docker

docker <TIPO_DE_OBJETO> <OPERACION> <ARGS>


----------------------

Apache HTTPD    --- Puerto: 80 IP? Una IP que se daba al contenedor en la red de docker: 172.17.0.XXX
Tomcat
MySQL
Jenkins


RED_EMPRESA -------------------------------------------
                    |                               |
                    PC1  (192.168.1.100)            PC2 (192.168.1.101)
                        | (172.17.0.1)
                        |
                        |---- HTTPD (172.17.0.2) < 80 
                        docker
                        
                        NAT: redirección:
                            192.168.1.100:8080   >>>>   172.17.0.2:80

CONFIGURACION DE CONTENEDORES:
A traves de ficheros de configuración:
    httpd     <<<<<    exit      <<<<<< Podría montarlo dentro del contenedor mediante un volumen
A través de variables de entorno:
    docker container create -e VARIABLE_ENTORNO_1=VALOR -e VARIABLE_ENTORNO_2=VALOR
    
    
docker container create \
    --name mimysql \
    -v /home/ubuntu/environment/datos/mysql:/var/lib/mysql \
    -e MYSQL_ROOT_PASSWORD=password \
    -e MYSQL_DATABASE=miDB \
    -e MYSQL_USER=usuario \
    -e MYSQL_PASSWORD=password \
    -p 3307:3306 \
    mysql:OTRA_VERSION

elasticsearch  <<<<<   INDEXADOR (GOOGLE)  <<<<< Stack ELK <<< Sistema de monitorizacion 

run:
    docker image pull + docker container create + docker start + docker attach (redirigir la stdout contenedor a la terminal desde donde ejecuto)
                                                                    -d   modo dettached


Aplicacion WEB:
    BBDD - MySQL                    C1 C7
    Serv. aplicaciones WEBSPHERE    C2 C3 C4 C5 C6



Persiana - Motor - Interruptor
    
Oye XXXXXXXX, a las 7 de la tarde quiero que cierres la persiana
              a las 7 de la mañana que abras la persiana
              
Kubernetes - Orquestador de contenedores

---------------------------------------------------------------------------------------------------------------------------------------------
Que caracteristicas necesitamos en un entorno de producción:
- Alta disponibilidad
- Escalabilidad

Cluster
    Activo - Pasivo   <    HA
    Activo - Activo   <    HA & Escalabilidad

Cluster Kubernetes
|       DNS   nombres, con sus IPs    <<<<<<<<<<<<< Kubernetes
|-    Maquina 1 - docker < Kub   PUF !!!!!
|-    Maquina 2 - docker < Kub
|        C7 - MySQL                          -----> IP7:3306
|        C6 - MySQL                          -----> IP6:3306   ------- Son de una red virtual privada a nivel de CLUSTER
|-    Maquina 3 - docker < Kub
|        C3 - Weblogic App1                  -----> IP3:7001   ------- Son de una red virtual privada a nivel de CLUSTER
|-    Maquina 4 - docker < Kub
|        C4 - Weblogic App1                  -----> IP4:7001   ------- Son de una red virtual privada a nivel de CLUSTER
                Quiero que conecte con la BBDD: Que necesito?
                    nombres<>DNS + PUERTO + usuario....
            **** Balanceador de carga WEBLOGIC  <<<< Me lo regala Kubernetes
            **** Balanceador de carga MYSQL  >>> IP6
                                             >>> IP7
                                             >>> IP8
        
    Almacenamiento SAN, NAS, Cloud
        
Cliente ... persona desde su PC ---> App1


Balanceador de carga?
    NetFilter  <  Programa que viene KERNEL DE LINUX y controla TODOS LOS PAQUETES DE RED QUE SE MANDAN en el SO
      ^^^^^
    IPTABLES
    
---------------------------------------------------------------------------------------------------------------------------------------

Supermercado                                                                                                    <<<< Cluster de Kubernetes
    Gerente                                                                                         KUBERNETES
    Carniceria                                                                                          <<<< Servicio
        Cartel                                                                                                          <<<<< DNS                                                                                                        
        Numerito                                                                                                        <<<<< Balanceo de carga
        Camaras frigorificas                                                                                <<<< Infraestrutura: Almacenamiento Persistente
            Carne                                                                                                   <<<< Datos
        Expositor                                                                                           <<<< Infraestrutura: Almacenamiento Persistentes
            Carne                                                                                                   <<<< Datos
        Puesto de trabajo                                                                                   <<<< Infraestructura: Servidor / Maquina
            Carnicero 1                                                                                         <<<< Contenedores (servicios)
        Puesto de trabajo - Mesa, cuchillos, picadoras, delantal
            Tabla de cortar                                                                                 <<<< Infraestrutura: Almacenamiento Efimero
            Carnicero 2
        Puesto de trabajo
            Carnicero 3 - Esta pàra atender / servir a la gente
                <<<<<  Cualidades, Cualificaciones                                                                  <<<<< Imagen del contenedor
    Pescaderia                                                                                                  <<<< Servicio
    Fruteria                                                                                                    <<<< Servicio
    Congelados
    Puerta 1                                                                                                <<<<< IngressController
        Señales/Carteles                                                                                        <<<<< Ingress - Reglas: 
        Vigilante 1 -  A esto no les piden nada.. ellos son autonomos                                           <<<< Contenedores (demonios)
    Puerta 2
        Vigilante 2
    Cajas                                                                                                       <<<< Servicio
        Esperar en una cola comun
        Se me manda a una caja
        Caja 1                                                                                             <<<< Infraestructura: Servidor / Maquina
                                                                                                                <<<<  POD
            Cajero aprendiz                                                                                         <<<< Contenedor
            + Cajero senior profesor                                                                                <<<< Contenedor
        Caja 7, cinta transportadora,...
            Cajero                                                                                              <<<< Contenedor
            Dinero                                                                                                  <<<< Datos
            
            
            
C1- Host 1                      docker SWARM   20% de la funcionalidad de kubernetes
MySQL1   > VOLUMEN 1   > Local / nfs
  ^V
MySQL2   > VOLUMEN 2   > Local / nfs
C2- Host 2

MariaDB 



POD: Conjunto de contenedores que:
    - Tenemos asegurado que se desplegarán en el mismo HOST
    - Escalarán de la misma forma
    - Comparten configuracion de RED (IP) -> POD. Entre ellos, se hablarán mediante: localhost
        Pod1
            C1 -> 80
            C2 : localhost:80

Podemos definir un POD en Kubernetes? SI
    Lo vamos a hacer alguna vez en la vida? NO
    ¿quien lo hará? Kubernetes
    A partir de que? DE UNA PLANTILLA DE POD, que es lo que nosotros vamos a definir

Objetos: están definidos en librerias
-----------
POD
NAMESPACE
CONFIGMAPS
SECRETS
PERSISTENTVOLUMES
PERSISTENTVOLUMECLAIMS
SERVICE
INGRESS
RESOURCEQUOTA
LIMITRAGES
DEPLOYMENTS
STATEFULSETS
DEAMONSETS
REPLICASETS

Openshift
------------
+ Objetos de Kubernetes + añade objetos propios definidos por RH

MACHINE
MACHINESET

Que he creado yo??? Un pod: pod-apache

POD-APACHE   ---> NODO-X
    Creado el contenedor: Arranca  ... si explota ... lo reinicia

Que pasa si NODO-X se cae
    Lo lleva a otra maquina si tuviera 5 maquinas? NO
    El pod-apache murio

Mover un pod... es ficticio: 
    Un pod lo borro
    Y me creo otro igual en otro sitio


Plantilla de POD + # replicas
    Y quien va a crear los pods va a ser Kubernetes
    Cuantos? Los que le haya pedido
    Y si uno muere?
        Creara otro para asegurar que sigo teniendo el numero que quiero

DEPLOYMENT     Plantilla de POD + # inicial de replicas ***
    Todos los pods son iguales... intercambiables
STATEFULSET    Plantilla de POD + # inicial de replicas ***
                + plantilla de peticiones de volumen
    Cada pod tiene su personalidad... no son intercambiables
DAEMONSET      Plantilla de POD 
    Se monta un pod en cada nodo del cluster

HPA (Autoescalador)
    - Que quiero autoescalar
    - en que rango: Min y max
    - en base a que? CPU , Memoria
        Medias de los usos en los pods
        
Escalar hasta 5 en base a uso CPU: 50%

Cada pod solo puede hacer uso de 2 CPUs
Nodo 1 
    Apache: 50%
Nodo 2 - 8 CPUs   30%
    Apache: 50%  - Sobre qué es? Sobre lo que le permito al POD
    Apache: 55%
    Apache: 30%
Nodo 3
    -

Apache: (70x70)/2= 70% -> Escalo
    
POD: Weblogic: 
    8 Gbs de RAM
    4 Cores



APACHE -> Mostrar unos ficheros html      DEPLOYMENT
    C1
    C3
    C4    

---------VVVVVVVV                         STATEFULSET
MARIADB                                 Almacenamiento Externo en RED

MARIADB1            Su ficheros independientes
MARIABD2            Su ficheros independientes
MARIADB3            Su ficheros independientes


KAFKA1          Dato1                 Dato3
*KAFKA2                       Dato2    Dato3    Dato4 PUF !!
KAFKA3          Dato1        Dato2             Dato4
KAFKA2'                       Dato2    Dato3    Dato4
KAFKA4          --------------------------------------------
KAFKA5          --------------------------------------------
KAFKA3'         Dato1        Dato2             Dato4

ES01
ES02
ES03