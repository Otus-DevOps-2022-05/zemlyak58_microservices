# zemlyak58_microservices
zemlyak58 microservices repository
# Создание instance ycloud
yc compute instance create \
  --name docker-host \
  --zone ru-central1-a \
  --network-interface subnet-name=default-ru-central1-a,nat-ip-version=ipv4 \
  --create-boot-disk image-folder-id=standard-images,image-family=ubuntu-1804-lts,size=15 \
  --ssh-key ~/.ssh/appuser.pub
# Запуск docker-machine
docker-machine create \
  --driver generic \
  --generic-ip-address=84.201.135.110 \
  --generic-ssh-user yc-user \
  --generic-ssh-key ~/.ssh/id_rsa \
  docker-host
# Подключение к Docker host'у
eval $(docker-machine env docker-host)
# Скачать архив
wget  https://github.com/express42/reddit/archive/microservices.zip
# Распаковать архив, переименовать каталог, удалить архив
unzip microservices.zip && mv reddit-microservices src && rm microservices.zip
# Создаём Dockerfile ./post-py/
# Создаём Dockerfile ./comment/
# Создаём Dockerfile ./ui/
# Сборка образов
docker pull mongo:latest
docker build -t zemlyak/post:1.0 ./post-py
docker build -t zemlyak/comment:1.0 ./comment
docker build -t zemlyak/ui:1.0 ./ui
# Создаём сеть 
docker network create reddit
# Создаём Docker volume
docker volume create reddit_db
# Запуск контейнеров с монтированым разделом
docker run -d --network=reddit --network-alias=post_db --network-alias=comment_db -v reddit_db:/data/db mongo:latest
docker run -d --network=reddit --network-alias=post zemlyak/post:1.0
docker run -d --network=reddit --network-alias=comment zemlyak/comment:1.0
docker run -d --network=reddit -p 9292:9292 zemlyak/ui:1.0
# Проверяем где docker-host-ip можно посмотреть $docker-mashine list
http://<docker-host-ip>:9292


