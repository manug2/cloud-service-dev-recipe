pipeline {
    agent { 
        kubernetes{
            label 'jenkins-slave'
        }
        
    }
    options {
        skipStagesAfterUnstable()
    }
    environment{
        DOCKER_USERNAME = credentials('DOCKER_USERNAME')
        DOCKER_PASSWORD = credentials('DOCKER_PASSWORD')
    }
    stages {
        stage('docker login') {
            steps{
                sh(script: """
                    docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD
                """, returnStdout: true) 
            }
        }

        stage('python UI docker build') {
            steps{
                sh script: '''
                #!/bin/bash
                cd ./python
                docker build . --network host -t manug2018/python:${BUILD_NUMBER}
                '''
            }
        }

        stage('python UI docker push') {
            steps{
                sh(script: """
                    docker push manug2018/python:${BUILD_NUMBER}
                """)
            }
        }

        stage('calc-service build') {
            steps{
                withMaven(
                    // Maven installation declared in the Jenkins "Global Tool Configuration"
                    maven: 'Maven_3.6.3', // (1)
                    // Use `$WORKSPACE/.repository` for local repository folder to avoid shared repositories
                    mavenLocalRepo: '.repository', // (2)
                    // Maven settings.xml file defined with the Jenkins Config File Provider Plugin
                    // We recommend to define Maven settings.xml globally at the folder level using
                    // navigating to the folder configuration in the section "Pipeline Maven Configuration / Override global Maven configuration"
                    // or globally to the entire master navigating to  "Manage Jenkins / Global Tools Configuration"
                    // mavenSettingsConfig: 'my-maven-settings' // (3)
                ){
                  sh script: '''
                  #!/bin/bash
                  cd ./calc-service
                  mvn clean install
                  '''
                }
            }
        }

        stage('calc-service docker build') {
            steps{
                sh script: '''
                #!/bin/bash
                cd ./calc-service
                docker build . --network host -t manug2018/calc-service:${BUILD_NUMBER}
                '''
            }
        }

        stage('calc-service docker push') {
            steps{
                sh(script: """
                    docker push manug2018/calc-service:${BUILD_NUMBER}
                """)
            }
        }

        stage('deploy service') {
            steps{
                sh script: '''
                #!/bin/bash
                chmod +x ./deploy/*.sh
                ./deploy/installKubeCtl.sh
                ./deploy/startCalcService.sh
                ./deploy/startPythonUI.sh
                '''
            }
        }

        stage('html-ui docker build') {
            steps{
                sh script: '''
                #!/bin/bash
                chmod +x ./html-ui/*.sh
                ./html-ui/processHtmlFile.sh
                cd ./html-ui
                docker build . --network host -t manug2018/html-ui:${BUILD_NUMBER}
                '''
            }
        }

        stage('html-ui docker push') {
            steps{
                sh(script: """
                    docker push manug2018/html-ui:${BUILD_NUMBER}
                """)
            }
        }

        stage('deploy html-ui') {
            steps{
                sh script: '''
                #!/bin/bash
                ./deploy/startHtml.sh
                '''
            }
        }

        stage('regression testpack') {
            steps{
                withMaven(
                    maven: 'Maven_3.6.3', // (1)
                    mavenLocalRepo: '.repository', // (2)
                ){
                  sh script: '''
                  #!/bin/bash
                  java -jar calc-service/target/calc-service*.jar
                  cd ./regression-tests
                  mvn clean verify -Dtest.calc.service.url=http://localhost:8500
                  '''
                }
            }
        }

    }
}
