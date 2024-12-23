# Nexus SERVER (AWS Ubuntu VM Machine 4) 

Created 4 AWS Ubuntu machine using Terraform.

1) Server ( To Create AWS EKS Cluster using Terraform)
2) Jenkins ( To create CICD Pipeline)
3) SonarQube ( To check Code review, bugs)
4) Nexus  ( To store the Application Artifacts repository version maintain)




# Nexus SERVER (To store the Application Artifacts repository version maintain) Commands
  

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
To install Nexus using docker image. Install Nexus as Docker container.
Here - d -detach mode, p- port mapping, first 8081 – Host machine port, 8081 – container port , sonatype/nexus3  - Docker Image name

```bash
$ docker run -d -p 8081:8081 sonatype/nexus3

```
To Check Docker container.

```bash
$ docker ps  
```

# For Linux (Access Nexus Server)
The application will be accessible at http://public-ip:8081

Acess Nexus server. Username and Password

```bash
$ Username - admin 
$ Password - is stored in path /nexus-data/admin.password file.
```

To Acess Nexus server Password go inside Docker container.

Here- it – interactive terminal, d361570c3335- container-id,  /bin/bash - using the bin shell terminal

```bash
$ docker exec -it  d361570c3335   /bin/bash
$ ls 
$ cd sonatype-work
$ ls 
$ cd nexus3
$ ls 
$ cat admin.password
```

