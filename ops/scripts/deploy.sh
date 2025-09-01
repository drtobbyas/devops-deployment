#!/bin/bash

set -e

# The script accepts an optional argument for the full image name with tag.
# If no argument is provided, it defaults to 'demo-app:latest'.
if [ -z "$1" ]; then
    echo "No image specified. Defaulting to 'demo-app:latest'."
    FULL_IMAGE_NAME="demo-app:latest"
else
    FULL_IMAGE_NAME=$1
fi

echo "Applying base Kubernetes manifests (excluding deployment)..."
# Apply all manifests except the deployment itself, as it needs substitution.
find k8s -type f ! -name 'deployment.yaml' -exec kubectl apply -f {} \;

echo "Deploying application with image: $FULL_IMAGE_NAME"
# Substitute the placeholder in the deployment manifest and apply it via stdin
sed "s|DOCKER_IMAGE_PLACEHOLDER|$FULL_IMAGE_NAME|g" k8s/deployment.yaml | kubectl apply -f -

echo "Waiting for deployment rollout to complete..."
kubectl rollout status deployment/demo-app

echo "Deployment successful."
kubectl get pods -l app=demo-app