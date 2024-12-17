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
