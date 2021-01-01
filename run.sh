docker kill ot
docker rm ot
docker build -t ot -f Dockerfile.Local .
docker run --name ot --network otnetwork -p 7171:7171 -p 7172:7172 ot
