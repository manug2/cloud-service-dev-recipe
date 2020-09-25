# Micro-services CI+CD Pipeline using AWS & Kubernetes (EKS) #

## What is a micro-service ##
Executable code focusing on ***one*** business capability
* Built independently of other code
* Can be deployed independently of other code

## What is CI ##
Fail fast, fail early, do Good
* Commit code several times a day (new features as well as fixes)
* Automatic & reliable testing
* Fix issues earlier
* Need DevOps to establish the pipeline & scale it for Enterprise
* We will use Jenkins

## What is CD ##
Automation with a human touch
* Automate deployment to all environments (needs effective config management)
* Build in manual gates as per organization culture & target customer
* Monitor effectively

## Demonstration ##

### Set up a Kubernetes cluster in AWS a.k.a. EKS ###
    * Install aws cli, eksctl, kubectl
        Refer to https://docs.aws.amazon.com/eks/latest/userguide/getting-started-console.html
    * Create your Amazon EKS cluster IAM role & user
    * Configure AWS cli & Setup SSH keys
        Refer to https://github.com/manug2/cloud-service-dev-recipe/blob/master/1_create-key-pair_steps.md
    * Install new EKS cluster using 'eksctl' & configure
        Refer to https://github.com/manug2/cloud-service-dev-recipe/blob/master/2_create-eks-cluster.md
        
### Set up Storage for Jenkins ###
Refer to 

    https://github.com/manug2/cloud-service-dev-recipe/blob/master/3_aws_add_persistent_storage.md

FYI, my steps follow Marcel Dempers' work

    https://github.com/marcel-dempers/docker-development-youtube-series/tree/master/jenkins/amazon-eks/readme.md

### Set up Jenkins on our cluster ###
    * Install Jenkins on k8s and setup Kubernetes plugin in its console (Manage Jenkins)
    Refer to 
        https://github.com/manug2/cloud-service-dev-recipe/blob/master/4_aws_jenkins_deployment.md
    * Install Pipeline Maven Integration Plugin (Manage Jenkins -> Plugin Manager)
    * Add Maven (Manage Jenkins -> Global Tool Configuration)
        * Note down Name for use in pipeline step 
    * Restart Jenkins

### Start Coding with CI ###
    * Set up a git repo (if not done)
        * Code a micro-service
        * Add automated unit tests
        * Check it compiles and passes unit tests
    * Add Jenkinsfile with steps to automate build
        * Add step for maven build
        * Add Dockerfile
        * Add step for docker build
    * Commit to git
    * Add Multibranch Pipeline (New Item) 
        * Input github repo link 
        * Choose to build for All branches in Discover branches)
    * Watch Jenkins build (run on k8s ephemeral jenkins slave pods)
    * If something does not work, fix and commit until build is SUCCESS.
        
### Do the CD ###
    * Add automated regression test pack
    * Add k8s delpoyment yaml
    * Add k8s service yaml (load balanced and exposed as a service)
    * Add jenkins steps to automate deployment to k8s (load balanced and exposed as a service)
    * Commit
    * Watch Jenkins build & deploy (run on k8s ephemeral jenkins slave pod)
    * Test the api using browser

        
### Add new application to the pipeline CICD ###
    * Add a simple HTML ui
    * Add jenkins steps to automate build of ui
    * Add jenkins steps to deployment of ui
    * Commit
    * Watch Jenkins build & deploy (ephemeral jenkins slave pods)
    * Test UI - API interaction
