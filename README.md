## CAVJ.DEV REPO

### Description
Repo for Teleport Deployment

## Resources

### Apps
1. ArgoCD :white_check_mark:
2. Authentik :white_check_mark:
3. Grafana :x:

### Databases
1. Postgres :x:
2. MongoDB :x:

### Kube
1. EKS :x:

### SSH Nodes
1. IAM :x:
2. Token :x:

### Linux Desktops
1. EC2 Large :x:

### Windows Desktops
1. HomePC :x:

### Networking
1. Cert-Manager :white_check_mark:
2. ExternalDNS :white_check_mark:
3. Traefik :white_check_mark:

### Monitoring
1. Alerta :white_check_mark:
2. Prometheus :white_check_mark:

### Implementation Plan migration to ArgoCD
The current implementation includes migrating hosted services to ArgoCD, and depolying new services. Each service will be deployed to ArgoCD, tested, and verified for successful deployment before moving on to the next service.
The implementation plan for follow this order of deployment.
1. Cert-Manager :white_check_mark:
2. ExternalDNS :white_check_mark:
3. Treafik Ingress Controller :white_check_mark:
4. Authentik :white_check_mark:
5. Prometheus :white_check_mark:
6. Alerta :white_check_mark:
7. Grafana
8. Teleport Cluster PG Backend
9. Teleport Cluster DynamoDB Backend
10. MongoDB
