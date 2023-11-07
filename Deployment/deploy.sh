#!/bin/bash

echo "Applying Ingress..."
kubectl apply -f Deployment/ingress.yml

echo "Applying Secrets..."
kubectl apply -f Deployment/secrets.yml

echo "Applying ConfigMap..."
kubectl apply -f Deployment/configmap.yml

echo "Applying Backend Deployment..."
kubectl apply -f Deployment/backend-deployment.yml

echo "Applying Backend Service..."
kubectl apply -f Deployment/backend-service.yml

echo "Applying Frontend Deployment..."
kubectl apply -f Deployment/frontend-deployment.yml

echo "Applying Frontend Service..."
kubectl apply -f Deployment/frontend-service.yml

echo "Deployment completed successfully."
