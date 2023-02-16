
pipeline {
  agent any 
 
  stages {
       stage ('git clone') {
          steps {
      echo "code is building"
       git 'https://github.com/janisheik/docker-file-.git'
          }
      }
        stage('build docker image') {
          steps {
              echo ("build docker image")
              sh sudo'aws ecr-public get-login-password --region us-east-1 | docker login --username AWS --password-stdin public.ecr.aws/m8a8q5v2'
              sh sudo'docker build -t tomcat .'
              sh sudo'docker tag tomcat:latest public.ecr.aws/m8a8q5v2/tomcat:latest'
              sh sudo'docker push public.ecr.aws/m8a8q5v2/tomcat:latest'
              sh sudo'chmod 666 /var/run/docker.sock'
         
          }
       }       
    
       stage('kubectl deploy'){ 
       steps
        {
          sh 'sudo kubectl apply -f tomcat.yaml'
          sh 'sudo kubectl get ns'
          sh 'sudo kubectl get svc'
           
        }
      } 
    }
 }
