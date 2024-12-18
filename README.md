# Blue-Green-Deployment
CICD Pipeline project , a BANK Application using Blue Green Deployment.

# Requirements and Point to noted 

1.	Blue – Production Environment | Green – New feature, Version Environment (Dummy Environment)

2.	Advantages- Zero Downtime, Upgrading from Version 1 to version 2

3.	Database- MySQL |  Frontend, Backend – Java, HTML CSS


# Architecture

1.	Below is the Architecure  | EKS CLUSTER

2.	Cluster IP is used for internal communication (Don’t expose the port of Internal DB to outside world)

3.	Application will be accessed to Load balancer IP is used to expose to outside world.

4. Application Pod is connected to Database by sending Request to service first



![image](https://github.com/user-attachments/assets/16df8510-c1c5-4674-a89e-da05d7d4d27c)

How application will communicate inside the cluster (Cluster pod communication)

![image](https://github.com/user-attachments/assets/46fd09bb-283f-41e2-8352-915dfa06e9d6)


# Application Output and URL

BANK Application Output. EKS LoadBalancer URL Before DNS Mapping.

<a href="http://ab2d915fa0c9944358cda0bb72345f7c-318956043.ap-south-1.elb.amazonaws.com/login"> EKS LoadBalancer URL Before DNS Mapping application LINK </a>

![image](https://github.com/user-attachments/assets/67f3dc2d-b6ab-406d-b101-449e98879cc6)


EKS LoadBalancer URL Before DNS Mapping.

<a href="www.ashucolors.xyz"> EKS LoadBalancer URL After DNS Mapping application LINK (www.ashucolors.xyz)</a>

![image](https://github.com/user-attachments/assets/50f3e077-1456-45ca-a390-50274dcdb4d5)

Jenkins CICD Pipeline.
![image](https://github.com/user-attachments/assets/575ad7cf-073c-4803-849a-2d081bcdc0ca)

![image](https://github.com/user-attachments/assets/5b1bf14a-3e27-4794-a43e-3a9c6fb70210)

SonarQube Code Review server.

![image](https://github.com/user-attachments/assets/4d0ea10d-e54d-4818-9546-82ddd52b65e6)

Nexus Artifact  Repository Storage server.

![image](https://github.com/user-attachments/assets/1ec7bb55-4d95-45e3-bb1a-24329fb253c7)



