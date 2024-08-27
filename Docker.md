# Build and Run Docker Image

## Build Prerequistes Image 
To avoid very long build time, we first create a image with all prerequistes and then from this image we create the WindNinja image (build of this baseimage take more than 10min)

- Go to baseimage folder
- `docker build -t windninja_prerequisites .`

## Build WindNinja Image
- Go to base directory (windninja)
- `docker build -t windninja .`

## Run WindNinja Image
- Go to the directory with your configuration file, topographie file and all that windninja need
- ```docker run --rm -i -v `pwd`:/data windninja /usr/local/bin/WindNinja_cli <conf_file.cnf>```