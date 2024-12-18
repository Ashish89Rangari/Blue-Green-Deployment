# SonarQube SERVER (AWS Ubuntu VM Machine 3) 

Created 4 AWS Ubuntu machine using Terraform.

1) Server ( To Create AWS EKS Cluster using Terraform)
2) Jenkins ( To create CICD Pipeline)
3) SonarQube ( To check Code review, bugs)
4) Nexus  ( To store the Application Artifacts repository version maintain)




# SonarQube SERVER (To check Code review, bugs) Commands
  

Update Packages 

```bash
$ sudo apt update -y
$ sudo apt-get update -y
$ sudo apt upgrade -y
$ sudo apt-get upgrade -y
```

To install Nexus and SonaQube using docker image. Need to install Docker.

```bash
$ sudo apt install docker.io -y

```
By default, root user has permission to run command we have to give ubuntu user permission.
Adding ubuntu user to docker group.

```bash
$ sudo usermod -aG docker ubuntu   
(or)  
$ sudo usermod -aG docker $USER 

```
After adding Ubuntu to Docker group to make this changes effectively.

```bash
$ newgrp docker

```
To install SonaQube using docker image.
Here - d -detach mode, p- port mapping, first 9000 – Host machine port, 9000 – container port ,sonarqube:lts-community - Docker Image name

```bash
$ docker run -d -p 9000:9000 sonarqube:lts-community

```
To Check Docker container.

```bash
$ docker ps  
```

# For Linux (Access SonarQube Server)
The application will be accessible at http://public-ip:9000

Acess SonarQube server. Username and Password

```bash
$ Login - admin 
$ Password - admin 
```