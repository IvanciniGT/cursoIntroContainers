Instalación de Kubernetes
--------------------------

Previos:
    Configurar Docker de una determinada forma
    Desactivar la swap

YA instalamos kubernetes:
    Todos los nodos:
        instalar que herramientas:  kubeadm :       Crear un cluster
                                                    Borrarlo
                                                    Agrega una máquina un un cluster
                                    kubectl:        Cliente que se comunica con el cluster
                                    kubelet:        Demonio de Kubernetes que corre en todas las maquinas del cluster
                                    ^   V
                                    ^   DOCKER  > CONTAINERD > RUNC > Crea los contenedores, los pare... descargue imagenes de contenedor
                                    ^
                                    API-MANAGER
                                    ^
                                    kubectl
    Solo en uno de los nodos:                                   kube-system
        kubeadm init    CREA EL CLUSTER.....                    ^^^
            Instala EL PLANO DEL CONTROL DE KUBERNETES:      NAMESPACE   --- Agrupación lógica de objetos dentro de un cluster
                                                                                ---- cLiente
                                                                                ---- entorno
                                                                                ---- despliegue
                                    COREDNS
                                    API-MANAGER
                                    SCHEDULLER
                                    ETCD
                                    KUBE-PROXY      <       Crear las reglas de netFilter en cada host 
            Teníamos que crear la Red Virtual Cluster:
                Flannel
                Calico
            >>> Fichero de configuración del cluster <<<< kubectl
                Lo copiamos a la ruta /home/USUARIO/.kube/config

CP1              <<<< También eres maestro
CP2 <   Maestro (CP) << kubeadm init
WK1      ^
WK2  Les añado al cluster  <<< kubeadm join
CP3               <<<< TU TAMBIEN



Para hablar con el cluster usabamos el comando kubectl 
    $ kubectl <VERBO> <TIPODEOBJETO> <ARGUMENTOS>
    
Tipos de objeto dentro de kubernetes:
    Namespace   ns
    Node
    Pod
    ConfigMap
    Secrets
    Services:       svc      
        ClusterIP:      Direccion IP:PUERTO  +   fqdn(DNS)    +   Balanceo de carga 
        NodePort:       ClusterIP + Redireccion de puertos a nivel de TODOS los host del cluster
        LoadBalancer:   NodePort  + Gestión de un balanceador externo.     Tenemos 1. Quien?     Proxy reverso: INGRESS_CONTROLLER
            En los cloud siempre me viene ya un balanceador externo
            En mi instalación debo montar: MetalLB
    Ingress: Reglas que doy a un proxy reverso (INGRESS_CONTROLLER)
    Deployments     |
    StatefulSets    | Plantillas de pods y cuantas replicas quiero en el cluster
    DaemonSets      |
    PersistentVolumeClaims    pvc

Verbos kubectl:
    get
    describe
                    edit  MUY FEO
    delete
    create

verbos sin tipo de objeto:
    apply < FICHERO YAML
    delete < FICHERO YAML

No todos los objetos se crea a nivel de namespace. Hay objetos globales en el cluster:
    Nodo
    Namespace
    PersistentVolume            pv

    
----
    
                                                        https
                POD                     SERVICIO         VVV              NODEPORT
dashboard: 10.244.0.58:8443  <<<< 10.103.153.200        :443  <<<<<     IP_PUBLICA : 31167
                                  kubernetes-dashboard                  3.248.254.118
                                  
                                  
                                  
thisisunsafe                                  



JENKINS
    Orquestador de tareas
    
    Ansible <<<< Automatizar tareas
    
    
    GITLAB <<<< CAMBIO
    ^^
Jenkins
    Tareas Ansible > Despliegues en Kubernetes
                     modulo kubernetes
                     modulo bash: kubectl ....
                     
                     
Montar un WORDPRESS
    Wordpress  >>> PHP >>> APACHE  
    Una BBDD MYSQL
    
--------------------------------------------------------------------------------    
    Namespace: miwordpress                                                          30080
                                                                                    ^^^^
                                            SERVICIO: Balanceo + IP:PUERTO (INTERNOS) + PUERTO EXTERNO
                                                    VVVVV
        Deployment -> miwordpress       --> 1 pod: miwordpress-ASDADSS-ASADAS
                                                    VVVVV
                                                Servicio: DNS + BALANCEO
                                                    VVVVV
        Deployment -> mimysql           ---> 1 pod: mimysql-AKFLK-298DS
                                                label: el-mysql-de-mi-wordpress
    
    
--------------------------------------------------------------------------------    

Deployment



PodTemplate



-------------
Empresa: 
    - Aplicacion de gestion de nominas:
        Quien la hace :
            Desarrollo
            Quien pide que esta app necesita una BBDD?
                Desarrollo
            Quien pide que necesito un apache?
                Desarrollo
                
    - Quien instala eso, segun las spec de desarrollo?
        SysAdmin <<<< Kubernetes
        
        
    - Quien lo va a hacer ahora?... la instalación: Kubernetes
    
    
    Namespace?
    
    Desarrollador: Ivan
        Deployments
        Services
        Statefulsets
        PersistentVolumeClaim > 10 Gbs, rapidito y rendudante
    
    Sysadmin
        Namespace
            ResourceQuotas      |
            LimitRanges         |   Limitacion de recursos en el cluster
        ConfigMaps
        Secrets
        Ingress
        PersistentVolumes     > 
            voy a crear un volumen de 10 Gbs rapidito y redundate
            
            
        Kubernetes dira´... mira tu ! si uno pide u nvolumen de 10 Gbs Rapiditoy redundante
        Y otro ha creado un volumen de 10 Gbs rapidito y redundante
            Pues se lo enchufo...        



Metologias agiles:                      Q&A
    App: 15 dias > Produccion > Pre (7 dias- dia )
    
    
Desarrollador commit > GIT > Jenkins > Despliegue PRODUCCION
Jefes de proyecto Metodologias Agiles: SCRUM <<<< 
DEVOPS <<<<<<<<<<<<< AUTOMATIZAR TODO
Jenkins > 
    Descargar codigo git
    compilar codigo
    lo somete a pruebas unitarias  < si funciona
    Si se pasan Se pasa por SONARQUBE < Analisis de calidad de codigo
    ANSIBLE, PUPPET, CHEF
    Se CREA un entorno de preproduccion .
    Con contenedores CHUPADO
        Instalo la app
        Se hacen pruebas funcionales de alto nivel <<< Q&A  <<<<  PROGRAMAS
                                                        Selenium
                                                        Appium
                                                        SoapUI
                                                        Postman
                                Las pruebas se hacen desde LINUX, WINDOWS, MACOS
                                    Con navegador EDGE
                                    CHROME
                                    FIREFOX
                                    OPERA
        Y si se superan
            Se genera un empaquetado de la app que se manda a un REPO DE ARTEFACTOS
                NEXUS, ARTFACTORY, REPO IMAGEN DE CONTENEDOR DE DOCKER
        
        Y despues CREO un entorno de produccion
            Y ahi instalo la app
        
        Y en paralelo registro aquiello donde lo tenga que registrar
        Mando cooreos a todo perro pichichi
        
        Hago unos smoke test
            Si no... MARCHA ATRAS! y que todo quede como estaba en la version anterior



El desarrollador me da el serv de aplicaciones <<<< 

SpringBoot <<<<< Microservicios 90%

Framework desarrollo que lleva embedido un TOMCAT

CAIXABANK
