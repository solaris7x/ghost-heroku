#!/bin/bash

if ! [ -z "$PORT" ];
then
        export server__port=$PORT
        echo "Port set to $PORT"
else
        echo "PORT var is empty"
fi
