    
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