docker kill otdb
docker rm otdb
docker build -t otdb .
docker run -d -p 3306:3306 --name otdb -e MYSQL_ROOT_PASSWORD=password otdb
docker network rm otnetwork
docker network create otnetwork
docker network connect otnetwork otdb
