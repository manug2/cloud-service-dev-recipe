## Create AWS ELS Kubernetes cluster ##

1. Change public key file name in the following eksctl command

        eksctl create cluster --name <cluster name> --version 1.17 --region us-east-2 --nodegroup-name linux-nodes --nodes 1 --node-type t2.small --nodes-min 1 --nodes-max 3 --node-volume-size 200 --ssh-access=true --ssh-public-key pub<key name>.pem --managed

2. Update kubeconfig

        aws eks --region <region> update-kubeconfig --name <cluster name>
    
3. Test k8s configuration

        kubectl get svc
    
4. Create kubernets name space for our jenkins installation

        kubectl create ns jenkins

If any issues, refer to https://docs.aws.amazon.com/eks/latest/userguide/getting-started-console.html

