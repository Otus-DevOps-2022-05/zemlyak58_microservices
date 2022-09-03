<!-- Создание образа в yc gitlab_ci -->
$ packer build -var-file=variables.json ./gitlab_image.json
<!-- проверка созданного образа -->
$ yc compute image list
<!-- Запуск instance с помощью terraform -->
$ terraform apply
<!-- Создание docker-machine -->
docker-machine create \
  --driver generic \
  <!-- --generic-ip-address=84.201.135.110 \ -->
  --generic-ip-address=`yc compute instance list | grep gitlab-ci | awk '{print $10}'` \
  --generic-ssh-user ubuntu \
  --generic-ssh-key ~/.ssh/appuser \
  docker-gitlab
<!-- Подключение к Docker host'у -->
eval $(docker-machine env gitlab-ci)

<!-- Добавляем переменую для docker-compoce -->
echo 'IP_INSTANCE='$(yc compute instance list | grep gitlab-ci | awk '{print $10}') >> .env

<!-- Запуск docker контейнеров -->
docker-compose up -d

<!-- Установка пароля для root gitlab -->
ubuntu@gitlab-ci:~$ sudo docker exec -ti gitlab-web-1 bash
root@gitlab:/# gitlab-rails console -e production
--------------------------------------------------------------------------------
 Ruby:         ruby 2.7.5p203 (2021-11-24 revision f69aeb8314) [x86_64-linux]
 GitLab:       15.2.2 (4ecb014a935) FOSS
 GitLab Shell: 14.9.0
 PostgreSQL:   13.6
------------------------------------------------------------[ booted in 46.14s ]
Loading production environment (Rails 6.1.4.7)
irb(main):001:0> u = User.where(id:1).first
=> #<User id:1 @root>
irb(main):002:0> u.password = '*******'
=> "+2yXU0YBp"
irb(main):003:0> u.password_confirmation = '*******'
=> "+2yXU0YBp"
irb(main):004:0> u.save!
=> true


<!-- создание группы -->
<!-- создания проекта -->
<!-- добавление remote -->
git remote add gitlab { my-url }


<!-- add CI/CD pipeline -->
wget 
https://gist.githubusercontent.com/Nklya/ab352648c32492e6e9b32440a79a5113/raw/265f383a48b980ac6efd9b4c23f2b68a6bf70ce5/.gitlab-ci.yml .gitlab-ci.yml
<!-- Добавление раннера -->
docker run  -d --name gitlab-runner --restart always -v /srv/gitlab-runner/config:/etc/gitlab-runner -v /var/run/docker.sock:/var/run/docker.sock gitlab/gitlab-runner:latest

<!-- Регистрация раннера -->
$ docker exec -it gitlab-runner gitlab-runner register \
> --url http://51.250.69.199/ \
> --non-interactive \
> --locked=false \
> --name DockerRunner \
> --executor docker \
> --docker-image alpine:latest \
> --registration-token GR1348941xqZgzhQ1czuYgipKbFtP \
> --tag-list "linux,xenial,ubuntu,docker" \
> --run-untagged

<!-- справка по значениям ранера -->
docker exec -it gitlab-runner gitlab-runner register --help

 && rm -rf ./reddit/.git


