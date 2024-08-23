multi stage docker build to build the vmod

docker build -t vmod-builder .
docker create --name vmod-builder vmod-builder
docker cp vmod-builder:/output - > output.tar.gz
docker rm vmod-builder
tar -xvzf output.tar.gz