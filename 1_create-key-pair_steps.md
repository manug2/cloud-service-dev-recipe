## Configure AWS cli & Setup SSH keys ##

### Configure AWS CLI ###

Login to aws to find Access key ID & Secret access key

Input ***us-east-2*** AWS region of ur k8s cluster when prompted

Input *json* when prompted for "Default output format

        aws configure
        
### Setup SSH keys ###
1. Choose a key file name and replace in command below (Using Git Bash)

        aws ec2 create-key-pair --key-name <key name> --query 'KeyMaterial' --output text >> <key name>.pem

2. Change file mode to 400

        chmod 400 <key name>.pem

3. Execute ssh-keygen from git bash to gen a pub key

        ssh-keygen -y -f <key name>.pem  > pub<key name>.pem

If any issues, refer to https://docs.aws.amazon.com/eks/latest/userguide/getting-started-console.html
