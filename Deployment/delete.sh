#!/bin/bash

echo "Deleting Frontend Service..."
kubectl delete -f frontend-service.yml

echo "Deleting Frontend Deployment..."
kubectl delete -f frontend-deployment.yml

echo "Deleting Backend Service..."
kubectl delete -f backend-service.yml

echo "Deleting Backend Deployment..."
kubectl delete -f backend-deployment.yml

echo "Deleting ConfigMap..."
kubectl delete -f configmap.yml

echo "Deleting Secrets..."
kubectl delete -f secrets.yml

echo "Deleting Ingress..."
kubectl delete -f ingress.yml

echo "Deletion completed successfully."
