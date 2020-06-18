#!/bin/bash

export USER_ID=$(id --user) 
export GROUP_UID=$(id --group)

echo "USER_ID=$USER_ID"
echo "GROUP_UID=$GROUP_UID"

docker-compose up -d

