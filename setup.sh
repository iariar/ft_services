printf "\n\033[1;34m███████╗████████╗     ███████╗███████╗██████╗ ██╗   ██╗██╗ ██████╗███████╗███████╗"
printf "\n\033[1;34m██╔════╝╚══██╔══╝     ██╔════╝██╔════╝██╔══██╗██║   ██║██║██╔════╝██╔════╝██╔════╝"
printf "\n\033[1;34m█████╗     ██║        ███████╗█████╗  ██████╔╝██║   ██║██║██║     █████╗  ███████╗"
printf "\n\033[1;34m██╔══╝     ██║        ╚════██║██╔══╝  ██╔══██╗╚██╗ ██╔╝██║██║     ██╔══╝  ╚════██║"
printf "\n\033[1;34m██║        ██║███████╗███████║███████╗██║  ██║ ╚████╔╝ ██║╚██████╗███████╗███████║"
printf "\n\033[1;34m╚═╝        ╚═╝╚══════╝╚══════╝╚══════╝╚═╝  ╚═╝  ╚═══╝  ╚═╝ ╚═════╝╚══════╝╚══════╝\033[0m"
printf	"\nBy: \n"
printf	"\033[33mIariss\033[0m\n\n"
echo "\033[0;34mDeleting minikube...\033[0m"
minikube delete
echo "\033[0;34mStarting minikube...\033[0m"
minikube start --driver=virtualbox
echo "\033[0;34mSetting up environment...\033[0m"
eval $(minikube docker-env)
echo "\033[0;34mStarting metalb deployment...\033[0m"
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.6/manifests/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.6/manifests/metallb.yaml
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
kubectl apply -f ./srcs/metalb.yaml
echo "\033[0;34mStarting mysql...\033[0m"
docker build ./srcs/mysql/ -t mysql
kubectl apply -f ./srcs/mysql/src/mysql.yaml
echo "\033[0;34mStarting phpmyadmin...\033[0m"
docker build ./srcs/phpmyadmin/ -t phpmyadmin
kubectl apply -f ./srcs/phpmyadmin/src/phpmyadmin.yaml
echo "\033[0;34mStarting wordpress...\033[0m"
docker build ./srcs/wordpress/ -t wordpress
kubectl apply -f ./srcs/wordpress/src/wordpress.yaml
echo "\033[0;34mStarting nginx...\033[0m"
docker build ./srcs/nginx/ -t nginx
kubectl apply -f ./srcs/nginx/src/nginx.yaml
echo "\033[0;34mStarting ftps...\033[0m"
docker build ./srcs/ftps/ -t ftps
kubectl apply -f ./srcs/ftps/src/ftps.yaml
echo "\033[0;34mStarting influxdb...\033[0m"
docker build ./srcs/influxdb/ -t influxdb
kubectl apply -f ./srcs/influxdb/src/influxdb.yaml
echo "\033[0;34mStarting grafana...\033[0m"
docker build ./srcs/grafana/ -t grafana
kubectl apply -f ./srcs/grafana/src/grafana.yaml
echo "\033[0;32mI finished.\033[0m"
echo "\033[0;34mOpening dashboard...\033[0m"
minikube dashboard