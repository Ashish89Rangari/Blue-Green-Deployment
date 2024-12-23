# SERVER (AWS Ubuntu VM Machine 1) 

Created 4 AWS Ubuntu machine using Terraform.

1) Server ( To Create AWS EKS Cluster using Terraform)
2) Jenkins ( To create CICD Pipeline)
3) SonarQube ( To check Code review, bugs)
4) Nexus  ( To store the Application Artifacts repository version maintain)




# SERVER (To Create AWS EKS Cluster) Commands
  

Update Packages 

```bash
$ sudo apt update -y
$ sudo apt-get update -y
$ sudo apt upgrade -y
$ sudo apt-get upgrade -y
```

Install AWS CLI to coomunicate with IAM AWS user.

```bash
$ curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
$ sudo apt install unzip
$ unzip awscliv2.zip
$ sudo ./aws/install
```
To configure With Secret & Access key.

```bash
$ aws configure

```
To create EKS cluster using terraform install terraform.

```bash
$ sudo snap install terraform --classic  
```
To Clone Git Repository .

```bash
$ git clone https://github.com/Ashish89Rangari/Blue-Green-Deployment.git 
```
EKS cluster creation Terraform code is in Cluster folder. Go inside Cluster folder and execute the terraform  command.
Note: 
1) Change the .pem file in variables.tf file.
2) Change the availability zone in main.tf file.

```bash
$ terraform init
$ terraform plan
$ terraform apply --auto-approve
$ terraform destroy --auto-approve
```

To communicate with Kubernetes EKS Cluster, Install Kubectl

```bash
$ sudo snap install kubectl  --classic

```
To connect with Kubernetes EKS Cluster, We aren't connected execute below command.
Here-  devopsashu-cluster - EKS cluster name, ap-south-1 - AWS region name

```bash
$ aws  eks  --region ap-south-1 update-kubeconfig --name devopsashu-cluster

```
To Check EKS cluster pods 

```bash
$ kubectl get pods
$ kubectl get nodes
$ kubectl get svc

```

RBAC(Role Base Access Control)
We should have permission to update deployment, create , delete to specific service account.

### Creating Service Account name "jenkins" in namespace "webapps"


```yaml
apiVersion: v1
kind: ServiceAccount
metadata:
  name: jenkins
  namespace: webapps
```

To Create service account and namespace. Here service-account.yml - YAML file copy the above code

```bash
$ vi service-account.yml
$ kubectl  create ns webapps
$ kubectl apply -f service-account.yml

```

Create role to have permission to Kubernetes resources such as pods, secrets ,nodes,deployments etc
We are giving  permission such as – get, patch, update , list,create, delete
Creating role and assigning the role to service account "jenkins".


### Create Role 


```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: app-role
  namespace: webapps
rules:
  - apiGroups:
        - ""
        - apps
        - autoscaling
        - batch
        - extensions
        - policy
        - rbac.authorization.k8s.io
    resources:
      - pods
      - secrets
      - componentstatuses
      - configmaps
      - daemonsets
      - deployments
      - events
      - endpoints
      - horizontalpodautoscalers
      - ingress
      - jobs
      - limitranges
      - namespaces
      - nodes
      - pods
      - persistentvolumes
      - persistentvolumeclaims
      - resourcequotas
      - replicasets
      - replicationcontrollers
      - serviceaccounts
      - services
    verbs: ["get", "list", "watch", "create", "update", "patch", "delete"]
```


To Create role. Here role.yml - YAML file copy the above code
Creating role and assigning the role to service account "jenkins".

```bash
$ vi role.yml
$ kubectl apply -f role.yml

```

To bind the role to service account "jenkins".
Role binding "kind -rolebind"


### Bind the role to service account


```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: app-rolebinding
  namespace: webapps 
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: Role
  name: app-role 
subjects:
- namespace: webapps 
  kind: ServiceAccount
  name: jenkins 
```
To bind the role to service account "jenkins". Here rolebind.yml - YAML file copy the above code

```bash
$ vi rolebind.yml
$ kubectl apply -f rolebind.yml

```



### Generate token using service account in the namespace

[Create Token](https://kubernetes.io/docs/reference/access-authn-authz/service-accounts-admin/#:~:text=To%20create%20a%20non%2Dexpiring,with%20that%20generated%20token%20data.)

Generate token using service account in the namespace. Write service account name "jenkins"

```yaml
apiVersion: v1
kind: Secret
type: kubernetes.io/service-account-token
metadata:
  name: mysecretname
  annotations:
    kubernetes.io/service-account.name: jenkins
```

To create service account "jenkins" token . Here service-account.yml - YAML file copy the above code

```bash
$ vi service-account.yml
$ kubectl apply -f rolebind.yml -n webapps

```

To generate the K8S authentication token.

```bash

$ kubectl describe secret mysecretname -n webapps

```


