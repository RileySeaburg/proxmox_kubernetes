#!/bin/bash

# Deploy Swagger UI pod
kubectl run swagger-ui \
  --image=swaggerapi/swagger-ui \
  --port=8080

# Expose the Swagger UI pod as a NodePort service
kubectl expose pod swagger-ui --type=NodePort --port=8080

# Retrieve the NodePort for the service
NODE_PORT=$(kubectl get svc swagger-ui -o=jsonpath='{.spec.ports[0].nodePort}')

# Retrieve the IP address of the node
NODE_IP=$(kubectl get nodes -o=jsonpath='{.items[0].status.addresses[?(@.type=="InternalIP")].address}')

echo "Swagger UI is available at: http://$NODE_IP:$NODE_PORT"
echo "Enter the Kubernetes OpenAPI endpoint (e.g., https://127.0.0.1:6443/openapi/v2) in the Swagger UI to explore the API."
