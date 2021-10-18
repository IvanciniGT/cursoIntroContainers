    1  uname -a
    2  whoami
    3  cd /home/ubuntu
    4  cd environment/
    5  pwd
    6  clear
    7  docker --version
    8  clear
    9  systemctl status dockerd
   10  systemctl status docker
   11  systemctl status docker
   12  clear
   13  docker --version
   14  docker version
   15  clear
   16  docker image list
   17  docker image rm 094248252696
   18  docker image list -q
   19  docker image rm $(docker image list -q)
   20  docker image list
   21  docker images
   22  docker pull httpd
   23  docker images
   24  docker rmi httpd
   25  docker pull httpd
   26  ls /var/lib/docker/images
   27  sudo ls /var/lib/docker/images
   28  sudo ls /var/lib/docker
   29  sudo ls /var/lib/docker/image
   30  sudo ls /var/lib/docker/image/overlay2
   31  clear
   32  clear
   33  which clear
   34  ls
   35  which ls
   36  docker image pull fedora
   37  docker images
   38  docker ps
   39  docker container list --all
   40  docker container create httpd:latest
   41  docker container list --all
   42  docker rm stupefied_montalcini
   43  docker container list --all
   44  docker container create --name miapache httpd:latest
   45  docker container list --all
   46  docker start miapache
   47  docker container list --all
   48  netstat -lnt
   49  curl localhost:80
   50  docker stop miapache
   51  curl localhost:80
   52  netstat -lnt
   53  docker start miapache
   54  docker container list --all
   55  ifconfig 
   56  ip a
   57  curl 172.17.0.2:80
   58  docker stop miapache
   59  curl 172.17.0.2:80
   60  docker start miapache
   61  curl 172.17.0.2:80
   62  docker pull nginx
   63  docker container create -n minginx nginx
   64  docker container create --name minginx nginx
   65  docker start minginx
   66  docker inspect minginx
   67  curl 172.17.0.3:80
   68  docker stop minginx
   69  curl 172.17.0.3:80
   70  docker logs minginx
   71  docker logs miapache
   72  docker container create --name miapache2 httpd
   73  docker start miapache2
   74  docker inspect miapache2 | grep IPA
   75  curl 172.17.0.3:80
   76  curl 172.17.0.2:80
   77  docker build
   78  docker container list
   79  docker container list --all
   80  docker ps 
   81  docker ps --all
   82  history
   83  docker container rm minginx
   84  docker rmi httpd
   85  ls /
   86  docker exec miapache ls /
   87  ls /home
   88  docker exec miapache ls /home
   89  docker exec miapache ls /bin
   90  docker exec miapache ls /etc
   91  docker exec miapache ls /bin
   92  clear
   93  docker exec miapache bash
   94  cd /
   95  ls
   96  ps -eaf
   97  clear
   98  ps -eaf | grep httpd
   99  ps -eaf | grep 15484
  100  docker inspect miapache
  101  docker build
  102  docker logs miapache
  103  docker exec -it miapache bash
  104  docker stop miapache
  105  docker start miapache
  106  docker exec -it miapache bash
  107  docker stop miapache
  108  docker rm miapache
  109  docker container create --name miapache httpd:latest
  110  docker start miapache
  111  docker exec -it miapache bash
  112  docker rm miapache -f
  113  docker container create --name miapache -v /datos:/home/ubuntu/environment/datos httpd:latest
  114  docker start miapache
  115  docker exet -it miapache
  116  docker exec -it miapache bash
  117  docker stop miapache
  118  docker rm miapache
  119  docker container create --name miapache -v /home/ubuntu/environment/datos:/datos httpd:latest
  120  docker start miapache
  121  docker start miapache
  122  ls
  123  cd datos/
  124  ls
  125  cat saluda.txt 
  126  docker exec -it miapache bash
  127  docker rm miapache -f
  128  docker container create --name miapache -v /home/ubuntu/environment/datos:/datos httpd:latest
  129  docker start miapache
  130  docker exec -it miapache bash
  131  cd curso
  132  git add *
  133  git init
  134  git add *
  135  git commit -m 'Dia 1'
  136  git branch -M main
  137  git remote add origin https://github.com/IvanciniGT/cursoIntroContainers.git
  138  git push -u origin main
  139  git config credentials.helper store
  140  git push -u origin main
  141  clear
  142  git clone https://github.com/IvanciniGT/cursoIntroContainers profesor
  143  clear
  144  docker image list # docker images
  145  #docker image pull REPO:TAG
  146  #docker container create --name NOMBRE -v RUTA_LOCAL:RUTA_CONTENEDOR IMAGEN
  147  docker network list
  148  docker ps --all
  149  docker container list -a
  150  docker container rm miapache -f 
  151  docker container rm miapache2 -f 
  152  docker ps --all
  153  clear
  154  netstat -lnt
  155  docker container create --name miapache httpd:latest
  156  docker start miapache
  157  netstat -lnt
  158  curl 172.17.0.2:80
  159  #docker container create --name miapache  -p IP_HOST:PUERTO_HOST:PUERTO_CONTENEDOR  httpd:latest
  160  docker container create --name miapache  -p  172.31.15.132:8080:80  httpd:latest
  161  docker container create --name miapache2 -p  172.31.15.132:8080:80  httpd:latest
  162  docker inspect miapache2 | grep IPA
  163  docker start miapache2
  164  docker inspect miapache2 | grep IPA
  165  curl 172.17.0.3:80
  166  curl 172.31.15.132:8080
  167  netstat -lnt
  168  docker stop miapache2
  169  netstat -lnt
  170  docker exec -it miapache bash
  171  #docker container create --name miapache2 -p  0.0.0.0:8080:80  httpd:latest
  172  netstat -lnt
  173  clear
  174  env
  175  docker exec -it miapache bash
  176  netstat -lnt
  177  docker container create     --name mimysql     -v /home/ubuntu/environment/datos/mysql:/var/lib/mysql     -e MYSQL_ROOT_PASSWORD=password     -e MYSQL_DATABASE=miDB     -e MYSQL_USER=usuario     -e MYSQL_PASSWORD=password     -p 3307:3306     mysql:tag
  178  docker container create     --name mimysql     -v /home/ubuntu/environment/datos/mysql:/var/lib/mysql     -e MYSQL_ROOT_PASSWORD=password     -e MYSQL_DATABASE=miDB     -e MYSQL_USER=usuario     -e MYSQL_PASSWORD=password     -p 3307:3306     mysql
  179  docker start mimysql
  180  netstat -lnt 
  181  docker exec -it mimysql mysql -u usuario -p  
  182  history
  183  clear
  184  df -h
  185  sudo apt install docker-compose -y
  186  docker-compose --version
  187  cd docker/mysql/
  188  docker-compose up
  189  docker-compose up
  190  docker-compose up
  191  docker stop mimysql
  192  docker-compose up
  193  docker-compose up -d
  194  docker logs mysql
  195  docker-compose down
  196  docker-compose up
  197  docker-compose stop
  198  docker-compose start
  199  cd ..
  200  cd ..
  201  git add *
  202  git commit -m 'dia2'
  203  git push
  204  cd curso/
  205  git add :(
  206  git add :/
  207  git commit -m 'dia2'
  208  git push
  209  git config credential.helper store
  210  git push
  211  cd ..
  212  cd cursoIntroContainers
  213  git clone https://github.com/IvanciniGT/cursoKubernetesCA kubernetes
  214  clear
  215  systemctl status docker
  216  docker version
  217  systemctl status docker
  218      sudo sed -i 's/--containerd=\/run\/containerd\/containerd.sock/--containerd=\/run\/containerd\/containerd.sock  --exec-opt native.cgroupdriver=systemd/' /lib/systemd/system/docker.service
  219  cat  /lib/systemd/system/docker.service
  220  sudo systemctl daemon-reload
  221  sudo systemctl restart docker
  222  systemctl status docker
  223      sudo sed -i 's/--containerd=\/run\/containerd\/containerd.sock/--containerd=\/run\/containerd\/containerd.sock  --exec-opt native.cgroupdriver=systemd/' /lib/systemd/system/docker.service
  224  free
  225  sudo swapoff -a # Desactiva solo ahora
  226  free
  227   /etc/fstab 
  228  cat  /etc/fstab 
  229  sudo sed -i 's/\/var/#\/var/' /etc/fstab    # Desactivación persistente
  230  cat  /etc/fstab 
  231  free
  232  curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
  233  sudo touch /etc/apt/sources.list.d/kubernetes.list
  234  echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
  235  sudo apt-get update
  236  sudo apt-get install kubeadm -y
  237  kubectl status kubelet
  238  systemctl status kubelet
  239  ip a
  240  sudo kubeadm init --pod-network-cidr=10.244.0.0/16
  241    mkdir -p $HOME/.kube
  242    sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  243    sudo chown $(id -u):$(id -g) $HOME/.kube/config
  244  kubectl get node
  245  cat $HOME/.kube/config
  246  clear
  247  kubectl get node
  248  hostname
  249  kubectl get pods
  250  kubectl get namespaces
  251  kubectl get pods --namespace kube-system
  252  kubectl describe pod coredns-78fcd69978-4dqgn -n kube-system
  253  kubectl get node
  254  kubectl describe ip-172-31-15-132 
  255  kubectl describe node ip-172-31-15-132 
  256  clear
  257  kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
  258  kubectl get pods --namespace kube-system
  259  kubectl get pods --namespace kube-system
  260  kubectl get nodes
  261  kubectl get nodes
  262  cd kubernetes/instalaciones/
  263  pwd
  264  ls -l
  265  clear
  266  ./instalacion_dashboard.sh --install
  267  clear
  268  kubectl get all -n kubermnetes-dashboard
  269  kubectl get all -n kubernetes-dashboard
  270  clear
  271  kubectl get pods -n kubernetes-dashboard
  272  kubectl get pods -n kubernetes-dashboard -o wide
  273  kubectl describe pod kubernetes-dashboard-78c79f97b4-s9bh9 -n kubernetes-dashboard
  274  clear
  275  kubectl get pods -n kubernetes-dashboard -o wide
  276  kubectl delete pod kubernetes-dashboard-78c79f97b4-s9bh9 -n kubernetes-dashboard
  277  kubectl get pods -n kubernetes-dashboard -o wide
  278  kubectl get services -n kubernetes-dashboard -o wide
  279  kubectl describe service kubernetes-dashboard -n kubernetes-dashboard
  280  kubectl scale deployment kubernetes-dashboard --replicas=2
  281  kubectl scale deployment kubernetes-dashboard --replicas=2 -n kubernetes-dashboard
  282  kubectl get pods -n kubernetes-dashboard -o wide
  283  kubectl scale deployment kubernetes-dashboard --replicas=8 -n kubernetes-dashboard
  284  kubectl get pods -n kubernetes-dashboard -o wide
  285  kubectl get pods -n kubernetes-dashboard -o wide
  286  kubectl get pods -n kubernetes-dashboard -o wide
  287  kubectl describe service kubernetes-dashboard -n kubernetes-dashboard
  288  df -h
  289  history
  290  kubectl describe service kubernetes-dashboard -n kubernetes-dashboard
  291  kubectl get services -n kubernetes-dashboard -o wide
  292  clear
  293  kubectl get services -n kubernetes-dashboard -o wide
  294  ./instalacion_dashboard.sh --patch-service
  295  kubectl get services -n kubernetes-dashboard -o wide
  296  netstat -lnt
  297  curl https://localhost:31167/
  298  curl -K https://localhost:31167/
  299  curl -k https://localhost:31167/
  300  cd ..
  301  cd ..
  302  cd curso/
  303  cd kubernetes/
  304  cd instalacion/
  305  history > comandos.sh
