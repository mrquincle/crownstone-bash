#!/bin/bash

cd ..

./get_spheres.sh | jq '.[] | [.name, .id]'
#./get_spheres.sh | jq '.[] | {name, id}'
