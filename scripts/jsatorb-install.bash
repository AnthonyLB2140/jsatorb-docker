#!/bin/bash

# -----------------------------------------------------------------------------
# JSatOrb project: JSatOrb Docker compose installing script
# -----------------------------------------------------------------------------
# This script has to be run once in order to install the JSatOrb Docker images 
# into the local Docker images repository, as they are not available through 
# DockerHub or anywhere else on the Web.
# -----------------------------------------------------------------------------

echo "Installing JSatOrb Docker images"

echo "-- JSatOrb frontend Docker image"
# Import the JSatOrb frontend Docker image.
docker import ./Docker/jsatorb-frontend-prod.tgz

echo "-- JSatOrb backend Docker image"
# Import the JSatOrb backend Docker image.
docker import ./Docker/jsatorb-backend-prod.tgz

echo "-- JSatOrb Celestrak Docker image"
# Import the JSatOrb Celestrak Docker image.
docker import ./Docker/thib21_jsatorb-celestrak-dev.tgz

echo "JSatOrb Docker images has been installed"