#!/bin/bash

# List all gRPC routes
meshes=$(gcloud network-services meshes list --location=global --format='get(name)' --filter='createTime<2024-06-20' --sort-by=createTime)

# Loop through each route and delete it
for mesh in $meshes; do
  echo "Deleting gRPC mesh: $mesh"
  gcloud network-services meshes delete $mesh --quiet --location=global
done

echo "All gRPC routes deleted."

