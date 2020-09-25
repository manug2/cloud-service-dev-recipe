## Deploy Jenkins ##

Follows steps of https://github.com/marcel-dempers/docker-development-youtube-series/tree/master/jenkins/amazon-eks/readme.md

1. Create RBAC for jenkins 

        kubectl apply -n jenkins -f ./docker-development-youtube-series-master/jenkins/jenkins.rbac.yaml 

    Should see following output

        serviceaccount/jenkins created
        clusterrole.rbac.authorization.k8s.io/jenkins created
        rolebinding.rbac.authorization.k8s.io/jenkins created

2. Deploy k8s yaml for jenkins
        
        kubectl apply -n jenkins -f ./docker-development-youtube-series-master/jenkins/jenkins.deployment.yaml
        kubectl -n jenkins get pods
    Note down name of our jenkins pod

3. Deploy k8s service yaml for jenkins

        kubectl apply -n jenkins -f ./docker-development-youtube-series-master/jenkins/jenkins.service.yaml 

4. Jenkins initial setup

        kubectl -n jenkins exec -it <podname> cat /var/jenkins_home/secrets/initialAdminPassword
        
    Looks like *1442c38cc9cb43dda9f7cec2cf767fe9*
    
5. Forward port

        kubectl port-forward -n jenkins <podname> 8080

6. Setup user and recommended basic plugins on ***http://localhost:8080*** (login using above password)
   
   Let it run and in the meanwhile, grab uid gid as per next step.

7. Log into EC2 instance - using AWS website EC2 connect page to get docker user id and group id

        [root@ip-192-168 ~]# id -u docker
    Looks like *1001*
        [root@ip-192-168 ~]# cat /etc/group | grep docker
    Looks like *docker:x:1950:ec2-user*

8. Configure Jenkins' Kubernetes Plugin by following steps using Marcel's github doc
        
        https://github.com/marcel-dempers/docker-development-youtube-series/blob/master/jenkins/readme.md
        
    Note: Set the docker id and gid at two places in the jenkins form for configuring cloud

9. Setup docker hub username and password in Manage Jenkins -> Global Credentials
