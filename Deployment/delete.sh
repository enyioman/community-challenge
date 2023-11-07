#!/bin/bash

echo "Deleting Frontend Service..."
kubectl delete -f Deployment/frontend-service.yml

echo "Deleting Frontend Deployment..."
kubectl delete -f Deployment/frontend-deployment.yml

echo "Deleting Backend Service..."
kubectl delete -f Deployment/backend-service.yml

echo "Deleting Backend Deployment..."
kubectl delete -f Deployment/backend-deployment.yml

echo "Deleting ConfigMap..."
kubectl delete -f Deployment/configmap.yml

echo "Deleting Secrets..."
kubectl delete -f Deployment/secrets.yml

echo "Deleting Ingress..."
kubectl delete -f Deployment/ingress.yml

echo "Deletion completed successfully."
