    
                                       (CLUSTERIP)                           (NodePort)             (LOADBALANCER)
CLUSTER KUBERNETES                          Red Interna     DNS Interno   Red externa del cluster   
                                             VVVV            VVVVVVVVV     VVVVVVV
    Pod_App1- IP1:Puerto1   |
        C1  |               |
        C2  |(Mismo host)   |
    Pod_App1- IP2:Puerto1   > Servicio app1- IPS1:PuertoS1 (nombre DNS) - PUERTO HOSTS 1         + Gestion BC Externo
        C1  |               |
        C2  |(Mismo host)   |
    Pod_App1- IP3:Puerto1   |
        C1  |               |
        C2  |(Mismo host)   |
        
    Pod_App2- IP4:Puerto2   |
    Pod_App2- IP5:Puerto2   > Servicio app2- IPS2:PuertoS2 (nombre DNS) - PUERTO HOSTS 2         + Gestion BC Externo
        
    Pod_App3- IP6:Puerto3   > Servicio app3- IPS3:PuertoS3 (nombre DNS) - PUERTO HOSTS 3         + Gestion BC Externo
    
    Pod_App4- IP7:Puerto4   |
    Pod_App4- IP8:Puerto4   > Servicio app4- IPS4:PuertoS4 (nombre DNS) - PUERTO HOSTS 4         + Gestion BC Externo
                                                            ^^^^^^^^^^
    ^^^^^^^^            ^^^^^^^^^^^^^^^^^^            Tener nombres que no cambien
    Kubernetes          HA / Escalabilidad
    ^^^^^^^^
    Plantillas  <<< HUMANOS
        Deployment
        StatefulSet
        DaemonSet
    
    
    Si un servicio tiene por detrás varios PODs: Cluster Activo / Activo       Escalabilidad y HA
    Si un servicio tiene por detrás un solo POD: Cluster Activo / Pasivo       HA
    
    
    90% Dias : 1 de cada 10 abajo - 36 dias /año
    99% Dias : 1 de cada 100 abajo - 3,6 dias /año
    99,9% Dias : 1 de cada 1000 abajo - 8 horas /año
    
    
    Un Servicio me ofrece DNS + IP + Puerto y Balanceo... pero me ofrece que? Gestión de Colas
    ISTIO > ENVOY-Proxy (Lleva gestión de colas)
                        (Securizar todas las comunicaciones internas del cluster)
                            > Generación de claves pub/priv + Certificados firmados por una CA (generada por ISTIO)
    
    Cuando quiero publicar un servicio ofrecido en el cluster?
        Servicio de tipo ClusterIP + Ingress
    Ingress?
        Reglas de un proxy reverso que instalo en Kubernetes (IngressController) - nginx
                                                                VVVVVVVVVVVV
                                                            Servicio de tipo LoadBalancer
    
    Let's encrypt  <<<< Directamente para cada regla ingress y generar un certificado en auto... renovarlo
    
------
En mi empresa tengo 120 microservicios <<<< Cada uno es una app

Imagen 
Parametros de configuración


Distintos tipos de software:
    Aplicación
    Contenedores:
        Servicio    <<< Puerto          Se ejecuta hasta el infito y mas alla!!!
        Demonio     <<< Sin puerto      Se ejecuta hasta el infito y mas alla!!!
        Script      <<< Sin puerto      Se ejecuta hasta que termine

Dentro de un pod de kubernetes solo podemos meter dentro de sus contenedores: Servicios + Demonios
Kubernetes está monitorizando el proceso que se ejecuta en el contenedor con id 1
Si ese proceso no está corriendo: Que piensa Kubernetes? Que el contenedor se ha caido... Inmediatamente ERROR y REINICIO

Apache (10 copias)
Logs de cada apache los quiero evacuar hacia un ES y para ello monto un Filebeat / Fluentd (10) > ES (1)
1 filebeat por cada apache

? Si quiero tener un proceso leyendo el mismo fichero que esta generando otro proceso
    ... donde me interesan que se ejecuten esos 2 procesos?

Apache -> Log1  50 Kbs Volumen FS con persistencia en RAM 
          Log2  50 Kbs Volumen FS con persistencia en RAM 
            --> FluentD ->                                                          ES
            
        Cada POD                x 25 copias
            C Apache  ***           25                      :80     Servicio
            C Filebeat              25   <<<< C Sidecar             Demonio
            
NetworkPolicy

kill SIGTERM <<<< TIMEOUT >>>> kill SIGKILL
sleep 3600

kubectl delete -f Ejemplo2-PodAvanzado.yaml -n default
kubectl delete -f Ejemplo2-PodAvanzado.yaml -n produccion
sleep 10

kubectl apply -f wordpress/namespace-desarrollo.yaml -n default
kubectl apply -f wordpress/namespace-produccion.yaml -n produccion
kubectl apply -f Ejemplo2-PodAvanzado.yaml -n default
kubectl apply -f Ejemplo2-PodAvanzado.yaml -n produccion

kubectl get all -n default -o wide
kubectl get all -n produccion -o wide

kubectl exec -it pod-pruebas -c ubuntu -n default -- bash
kubectl exec -it pod-pruebas -c ubuntu -n produccion -- bash





DEFAULT
pod/pod-pruebas      10.244.0.76    80              localhost
service/nginx        10.101.131.42 8080             nginx

PRODUCCION
pod/pod-pruebas     10.244.0.77
service/nginx       10.107.216.217 8080

Estoy en ubuntu default
    quiero atacar a nginx de default.
        curl localhost:80
        curl 10.244.0.76:80
        curl 10.101.131.42:8080
        curl nginx:8080
        curl nginx.default:8080
        
Cuantos servicios llamados expresamente "nginx" tengo en el cluster ahora mismo? 2
Quien esta contestando? El del mismo namespace

Estoy en ubuntu default
    quiero atacar a nginx de produccion.
        curl 10.244.0.77:80             RUINA !!!
        curl 10.107.216.217:8080        RUINA GRANDE!!!
        curl nginx.produccion:8080      GUAY !!!!!


POD:
    Conjunto de contenedores que:
        - Van en el mismo host
        - Misma configuracion de red
        - Escalan juntos
        - Pueden compartir Volumenes
        
        
1 Gi   ---   1 Gibibyte = 1024 Mb = 1024 x 1024 Kb = 1024 x 1024 x 1024 b
1 Mb   ---   1 Mebibyte

1 Gb   ---   1 Gigabyte = 1000 Mb = 1000 x 1000 Kb = 1000 x 1000 x 1000 b




Nodo 1 cluster
    SO: nfs-client
    PODS
Nodo 2 Cluster
    SO: nfs-client
    PODS


Servidor NFS
    /exp/ruta1

Dato1, DAto2



BALANCEADOR 
Query 4 sitios de donde leer


Servicio
Balanceador -> Nodo1 -> Dato2 -> Nodo3


Nodo 1
        Dato1       Dato3   
Nodo 2
        Dato1       Dato3  
        
Nodo 3
        Dato2       Dato4   
Nodo 4
        Dato2       Dato4

Hasta que no grabo en las 4 no se por bueno... sigo limitado


StatefulSet
    Kafka
    MariaDB
    MySQL
    Oracle
    ES
    
    
    TAINT MNTO NODOS TODOS