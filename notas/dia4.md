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



