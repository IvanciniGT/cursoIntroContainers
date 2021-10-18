Kubernetes / Openshift

Orquestadores de contenedores en cluster de máquinas.
K8S - (OS) se encargan de operar los sistemas, y de las instalaciones y mantenimiento de las mismas.

Pod: 
    Conjunto de Contenedores:
        - Mismo host
        - Misma conf de red
        - Escalan juntos

Plantilla de Pod:
    * Deployment     + número de replicas
    * StatefulSet    + número de replicas    ++++   VOLUMENES
    - DaemonSet      ( numero de replicas: fijo: 1 por host)

Servicios:
    - ClusterIP:        nombre DNS + balanceo de carga       <<<< Servicios internos al cluster
                        NO HAY GESTION DE COLAS
    - NodePort          CLUSTERIP + Abre un puerto en los host para exponer el servicio
    - LoadBalancer      NodePort + gestion automatizada de un balanceador de carga externo


------
Deployment: Plantilla POD. Contenedores:    >>>> 3 replicas
    Apache httpd

| Red de mi empresa
|- Clientes: 192.168.1.198
|           Navegador : http://192.168.1.100 : 80
|                                miserv_produccion   ---> DNS (192.168.1.100)
|
|- DNS externo al cluster miserv_produccion ---> 192.168.1.100
|- Balanceador de CARGA - IP: 192.168.1.100 : 80   >>>> 192.168.2.201:30080, 192.168.2.202:30080, 192.168.2.203:30080, 192.168.2.204:30080
|   TODA LA GESTION DE ESTE BALANCEADOR DE CARGA ME LA COMO YO !!!!!   No me mola
Cluster Kubernetes (DNS):
|-    Nodo1 - SO Linux                                      ----- 192.168.2.201:    30080  >>> apache-prod-app1 IPS2:8080
|                    Kernel:
|                        netFilter:
|                           192.168.2.201:30080  >>> apache-prod-app1 IPS2:8080
|                           IPS1  > IP4:3306,IP6:3306
|                           IPS2  > IP1:80,IP2:80,IP3:80
|-        Pod1 - Apache (app1)  ----- IP1:80            ++++++                          <<   SERVICIO EXTERNOS DEL CLUSTER
|                    mysql-prod-app1:3306 < MySQL
|-    Nodo2 - SO Linux                                      ----- 192.168.2.202:    30080  >>> apache-prod-app1 IPS2:8080
|                    Kernel:
|                        netFilter:
|                           IPS1  > IP4:3306,IP6:3306
|                           IPS2  > IP1:80,IP2:80,IP3:80
|-        Pod2 - Apache (app1)  ----- IP2:80            ++++++                          <<   SERVICIO EXTERNOS DEL CLUSTER
|                    mysql-prod-app1:3306 < MySQL
|-        Pod3 - Apache (app1)  ----- IP3:80            ++++++                          <<   SERVICIO EXTERNOS DEL CLUSTER
|                    mysql-prod-app1:3306 < MySQL
|-        Pod6 - MySQL   ----- IP6:3306    ### BBDD Interna que utilizan los Apaches    <<   SERVICIO INTERNO DEL CLUSTER
|-    Nodo3 - SO Linux                                      ----- 192.168.2.203:    30080  >>> apache-prod-app1 IPS2:8080
|                    Kernel:
|                        netFilter:
|                           IPS1  > IP4:3306,IP6:3306
|                           IPS2  > IP1:80,IP2:80,IP3:80
|-    Nodo4 - SO Linux                                      ----- 192.168.2.204:    30080  >>> apache-prod-app1 IPS2:8080
|                    Kernel:
|                        netFilter:
|                           IPS2  > IP1:80,IP2:80,IP3:80
|                           IPS1  > IP4:3306,IP6:3306
|-        Pod4 - MySQL   ----- IP4:3306    ### BBDD Interna que utilizan los Apaches    <<   SERVICIO INTERNO DEL CLUSTER
|
|  <<<< RED VIRTUAL que monta kubernetes
|- IP Para el servicio mysql-prod-app1    IPS1:13306  > IP4:3306,IP5:3306
|- IP Para el servicio apache-prod-app1    IPS2:8080  > IP1:80,IP2:80,IP3:80
|

CLUSTER: 
    Lista de servicios:
        mysql-prod-app1 ----> IP del servicio (del balanceador de carga)
        apache-prod-app1 ----> IP del servicio (del balanceador de carga) IPS2


Las IP de los PODS son efimeras... si cambia un pod de ubicacion (borrado de un pod y creacion de uno nuevo)
                               ... si actualizo a una nueva versión de MySQL también cambia la IP


Un servicio nos evita:
    - Montar un servidor DNS
    - Configurar DNSs
    - Montar Balanceadores de Carga
    - Configurar el Balanceador de carga
    - Mantener el Balanceador de carga
    
    
----------
Instalación de contenedores mediante DOCKER
    Contenedor - Su propia dirección IP: De una red lógica montada por DOCKER a nivel de HOST
        IPC:PUERTO
    Para exponer ese servicio haciamos una redireccion de puertos: IP_HOST:PUERTO_HOST   -->  IPC:Puerto
    
Kubernetes
    IP_TODOS_LOS_HOST:PUERTO_HOST[ > 30000 ]    -->  IPServicio:Puerto_Servicio   -> IP Pod : puerto_pod (Contenedor)
                                                        Balanceo de carga
                                                        
                                                        
----- Para poder utilizar un servicio de tipo LOAD BALANCER:
    - Necesitamos disponer YA de antemano de un BALANCEADOR DE CARGA EXTERNO...
        - Que además sea compatible con Kubernetes

Cuando trabajamos con cualquier cloud, y le pedimos un cluster de kubernetes/Openshift
    Nos "regalan" (€€€€€€) un balanceador de carga externo montado, integrable con Kubernetes 
    AQUI SI PUEDO UTILIZAR SERVICIOS DE TIPO LOAD BALANCER
---Si trabajamos con un cluster de Kubernetes ON PREMISSES
    A priori no puedo utilizar servicios de tipo LOADBALANCER    < METALLB
    
    
Servicios:
    - ClusterIP:            90% <<< Para servicios que no exponer fuera del cluster
    - NodePort:             0  No se usa directamente salvo en entrnos de pruebas
    - LoadBalancer:         10% <<< Cada app del cluster que quiera exponer 

Servicios:
    - ClusterIP:            Todos - 1
    - NodePort:             0  No se usa directamente salvo en entrnos de pruebas
    - LoadBalancer:         1 <<<<<<<<<< Proxy reverso que gestione COLAS <<<<<<< INGRESS Controller
                                            Nginx
                                            Apache httpd
                                Las reglas con las que configuramos este gestor de colas / Proxy reverso se denominan INGRESS

Virtualhosts
    url host--- myapp1 -> servicio interno del cluster
    url host--- myapp2 -> servicio interno del cluster
        http://serv_prod/app1 -> serv app1
        http://serv_prod/app2 -> serv app2
    
    
IP PUBLICA 
        -> BALANCAEADOR EXTERNO AL CLUSTER  (METAL LB)
                -> Nodo del cluster (Regla netfilter + balanceo)
                        -> Servicio                    (Regla netfilter + balanceo)
                                -> Pod/Contenedor (IngressController: nginx)
                                        -> Reglas de configuracion (INGRESS) 
                                                --> Servicio Interno del cluster (Regla netfilter + balanceo)
                                                        -> Pod/Contenedor (app en funcionamiento)

    
Porque necesito un proxy reverso (Ingress Controller) si puedo a cada servicio darle su propia IP publica
    - Cada IP publica cuesta pasta
    - Mas configuraciones de DNS


4 cluster  replicado pre pro
    50 maquinas 

cluster OS 4 nodos   BANCOS


Seguros medicos


------------------------------------------------------
Cluster enormes todas las cosas de prod de una empresa
¿Cuantas apps pueden ser esto?
    Tropetantasmil   >>> Servicios
    
    weblogic prod app1    ---|
    bbdd oracle prod app1  <<|
            ^^^^    
    apache tomcat app des 5 ---|
    mysql app5 des          <<<|
    
    Reglas de red (Firewall)
    
    
    Servicios y Microservicios - Arquitectura para desarrollo de apps
        Las apps eran monoliticas MEGA-APLICACION
        
    
    Sistemas: Conjunto de servicios / microservicios que hablan entre si y juntos ofrecen una funcionalidad    
                      SOAP(XML)   HTTP(s)   REST (JSON)
    
Seguridad?

https:
    Me da una capa TLS sobre HTTP
    Que nos ayuda a "evitar" (MAL) - frustrar :
        - Man in the middle
        - Phishing - suplantacion de identidad
    
    Certificado - Me ayuda a probar que soy quien digo ser = DNI   FIRMADO POR UNA CA
    Claves publicas y privadas 
    
    
          ----------------------------------------
Programa 1    >>> DATOS ENCRIPTACION >>>          Programa 2
          ----------------------------------------
                ^^^ MitM = Alguien espia el canal de comunicación
                
DNS                
Cliente     >>> Datos de login >>>>           BANCO PIRATA (  CERTIFICADO)
                    Autenticación
                    
                    

ISTIO - - LINKERD
    MAN IN THE MIDDLE
    

POD                              POD
  C. Apache  ----->>              C. Weblogic
    ^^ localhost                     ^^ localhost
  C. ENVOY (Sidecar) -----------> C. ENVOY (sidecar)
  
  TODA COMUNICACION QUE ENTRA O SALE DEL POD, es interceptada por el proxy (envoy)
  
  
  
  Redhat
    SElinux      2 modos 
            permisivo
            forzado
    
  
  
  
  
  KUBERNETES:
  
    kubeadm < Gestiones a nivel de cluster
                Crear un cluster
                Borrar un cluster
                Añadir una maquina a un cluster
    kubectl < cliente de linea de comandos de kubernetes   
    kubelet < Demonio que vamos a tener corriendo en cada maquina del cluster
    
    
Tiene un monton de programas en ejecución
    Plano de control de kubernetes:
        Base de datos: etcd (mongo db)
        Servidor de DNS
        Scheduller                      <<<<<     Asignar los pods a máquinas
        ApiManager                      <<<<<     Recibe las peticiones del kubectl
        ControllerManager               <<<<<     Monitorizando los pods
        
        
docker <TIPO> <VERBO>  <ARGS>

kubectl <VERBO> <TIPO> <ARGS>


Namespace: Espacio de nombres (IDENTIFICADORES)
Cluster kub:
    POD:            nginx-pod
    SERVICIO:       servicio-nginx

Namespace Desarrollo
    POD:            nginx-pod
    SERVICIO:       servicio-nginx
Namespace Pre
    POD:            nginx-pod
    SERVICIO:       servicio-nginx
Namespace Pro
    POD:            nginx-pod
    SERVICIO:       servicio-nginx
    
    
default



KUBERNETES / OS
    Sysadmins <<<< Instalacion
                    Mantenimiento
                    Crear de ciertos tipos de objetos
                            Volumenes
                            Provisionadores de volumenes automatizados
                            ConfigMaps
                            Secrets
                            Ingress
                    HELM
    Desarrolladores  <<<<< Escribir ficheros de despliegue: Deployments
                                                            Statefulset
                                                            Services
                                                                CHART > HELM
    Monitorizacion   <<<<<  Prometheus / grafana     << Interfaz grafica
                                ^^      
                                Repo de metricas
                            ElastisSearch / Kibana
    Seguridad
        Secrets
        NetworkPolicies <<<<<<
        ISTIO (OPERADOR)
        
        

Intro Contenedores - Docker Docker compose 20 horas
Generacion de imagnes de contenedore   - 25 horas
Kubernetes                          - 40 horas
Administracion de Kubernetes        - 25
Helm                                - 30
Istio                               - 25 horas 





Servidores WEB  APACHES   WEBLOGICS: 100 servidores 
                    VV        VVV
                    access1.log 50 Kbs
                    access2.log 50 Kbb



Fluentd     >>>> Prometheus  
FileBeat    >>>> ElasticSearch <<< Kibana
Logstash


POD 
    Contenedor Apache --> Fichero de log
    Contenedor Filebeat ---^^^^^^  --> ES  Sidecar del Apache
