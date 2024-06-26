#!/bin/bash

# List all gRPC routes
routes=$(gcloud network-services grpc-routes list --location=global --format='table(name,createTime)' --filter='createTime<2024-06-20')

# Loop through each route and delete it
for route in $routes; do
  echo "Deleting gRPC route: $route"
  gcloud network-services grpc-routes delete $route --location=global --quiet
done

echo "All gRPC routes deleted.":
