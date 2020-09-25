## Configure AWS cli & Setup SSH keys ##

Login to aws IAM

    https://console.aws.amazon.com

Create new role for "EKS - Cluster" under EKS
    
    https://docs.aws.amazon.com/eks/latest/userguide/getting-started-console.html#role-create

Create new admin user with group Administrator
    
    https://console.aws.amazon.com/iam/home#/users

### Configure AWS CLI ###

Find Access key ID & Secret access key for the new user created above

        aws configure

Leave default (us-east2) AWS region of ur k8s cluster when prompted

Leave default (json) when prompted for "Default output format"
        
### Setup SSH keys ###
1. Choose a key file name and replace in command below (Using Git Bash)

        aws ec2 create-key-pair --key-name <key name> --query 'KeyMaterial' --output text >> <key name>.pem

2. Change file mode to 400

        chmod 400 <key name>.pem

3. Execute ssh-keygen from git bash to gen a pub key

        ssh-keygen -y -f <key name>.pem  > pub<key name>.pem

If any issues, refer to https://docs.aws.amazon.com/eks/latest/userguide/getting-started-console.html
