# Jenkins SERVER (AWS Ubuntu VM Machine 2) 

Created 4 AWS Ubuntu machine using Terraform.

1) Server ( To Create AWS EKS Cluster using Terraform)
2) Jenkins ( To create CICD Pipeline)
3) SonarQube ( To check Code review, bugs)
4) Nexus  ( To store the Application Artifacts repository version maintain)




# Jenkins SERVER (To Create CICD Pipeline) Commands
  

Update Packages 

```bash
$ sudo apt update -y
$ sudo apt-get update -y
$ sudo apt upgrade -y
$ sudo apt-get upgrade -y
```

Install Java 17. Headless means no UI for Java.

```bash
$ sudo apt install openjdk-17-jre-headless  -y

```
To Install Jenkins in Linux Ubuntu Machine. LTS (Long term support ) Version

```bash
$  sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
$  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
$  echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]" \
$  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
$  /etc/apt/sources.list.d/jenkins.list > /dev/null
$  sudo apt-get update
$  sudo apt-get install jenkins

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

After Installing Jenkins run this specific command to Start Jenkins.

```bash
$ sudo systemctl enable jenkins 
$ sudo systemctl start jenkins
$ sudo systemctl status jenkins
```

# For Linux (Access Jenkins Server)
The application will be accessible at http://public-ip:8080

Acess SonarQube server. Username and Password

```bash
$ Username - Your name
$ Password - 
```
To Acess Jenkins server Password go inside server the path is /var/lib/jenkins/secrets/initialAdminPassword.

```bash
$ sudo cat /var/lib/jenkins/secrets/initialAdminPassword

```

To install  Docker in Jenkins from official site. ubuntu

```bash

$ # Add Docker's official GPG key:
$ sudo apt-get update -y
$ sudo apt-get install ca-certificates curl
$ sudo install -m 0755 -d /etc/apt/keyrings
$ sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
$ sudo chmod a+r /etc/apt/keyrings/docker.asc

$ # Add the repository to Apt sources:
$ echo \
$  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
$  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
$ sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
$ sudo apt-get update -y
```

To install docker latest version, run:

```bash
$ sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

```

Changing the permissions giving Jenkins user all docker permissions.

```bash
$ sudo usermod -aG docker jenkins 
```

Installing trivy Plugins. Ubuntu

```bash

$ sudo apt-get install wget apt-transport-https gnupg lsb-release
$ wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | sudo apt-key add -
$ echo deb https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main | sudo tee -a /etc/apt/sources.list.d/trivy.list
$ sudo apt-get update -y
$ sudo apt-get install trivy -y

```

To communicate with Kubernetes EKS Cluster, Install Kubectl

```bash
$ sudo snap install kubectl  --classic

```

Install important plugins for project. In Jenkins Availabe Plugins section.

```bash
$ SonarQube Scanner
$ Config File Provider
$ Maven Integration
$ Pipeline Maven Integration
$ Pipeline: Stage View
$ Docker Pipeline
$ Kubernetes
$ Kubernetes Client API
$ Kubernetes Credentials
$ Kubernetes CLI
```

In Tools Section of Jenkins configure important tools for project. 

```bash
$ add maven
$ add SonarQube Scanner
```