## Add persistent storage in AWS ##

1. Deploy EFS storage driver

        kubectl apply -k "github.com/kubernetes-sigs/aws-efs-csi-driver/deploy/kubernetes/overlays/stable/?ref=master"

2. Get VPC ID. Looks like *vpc-05cd317513309e27f*
    
        aws eks describe-cluster --name <cluster name> --query "cluster.resourcesVpcConfig.vpcId" --output text

3. Get CIDR range. Looks like *192.168.0.0/16*

        aws ec2 describe-vpcs --vpc-ids <vpc id> --query "Vpcs[].CidrBlock" --output text

4. Create a new Security group for our instances to access file storage. Looks like *sg-0ec3e918d451b93a4*

        aws ec2 create-security-group --description <efs desciption> --group-name <efs group name> --vpc-id <vpc id>

5. Authorize security group for ingress

        aws ec2 authorize-security-group-ingress --group-id <group id>  --protocol tcp --port 2049 --cidr <cidr range>

6. Create storage and copy *FileSystemId* & *FileSystemArn* from output

        aws efs create-file-system --creation-token <some token string>

7. Create mount point & copy *MountTargetId*. For this you need to grab subnet id of the EC2 instance created by eksctl.

        aws efs create-mount-target --file-system-id <fs id> --subnet-id <subnet id> --security-group <security group id>

8. Grab our volume handle to update our PV YAML. Looks like *fs-2ea42d56*

        aws efs describe-file-systems --query "FileSystems[*].FileSystemId" --output text

9. Add PV to kubernetes using yaml files in folder ***docker-development-youtube-series-master/jenkins/amazon-eks***

        kubectl get storageclass
        kubectl apply -f ./docker-development-youtube-series-master/jenkins/amazon-eks/jenkins.pv.yaml 
        kubectl get pv
        
    Looks like *jenkins   5Gi        RWX            Retain           Available           efs-sc                  17s*

10. Create volume claim

        kubectl apply -n jenkins -f ./docker-development-youtube-series-master/jenkins/amazon-eks/jenkins.pvc.yaml
        kubectl -n jenkins get pvc
        
    Looks like *jenkins-claim   Bound    jenkins   5Gi        RWX            efs-sc         9s*
