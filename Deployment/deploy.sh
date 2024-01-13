#!/bin/bash

echo "Applying Ingress..."
kubectl apply -f ingress.yml

echo "Applying Secrets..."
kubectl apply -f secrets.yml

echo "Applying ConfigMap..."
kubectl apply -f configmap.yml

echo "Applying Backend Deployment..."
kubectl apply -f backend-deployment.yml

echo "Applying Backend Service..."
kubectl apply -f backend-service.yml

echo "Applying Frontend Deployment..."
kubectl apply -f frontend-deployment.yml

echo "Applying Frontend Service..."
kubectl apply -f frontend-service.yml

echo "Deployment completed successfully."
