
pipeline {
  agent any 
 
  stages {
       stage ('git clone') {
          steps {
      echo "code is building"
       git 'https://github.com/janisheik/error.git'
          }
      }
        stage('build docker image') {
          steps {
              echo ("build docker image")
              sh 'aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin 977134366673.dkr.ecr.ap-south-1.amazonaws.com'
              sh 'sudo docker build -t tomcat .'
              sh 'docker tag tomcat:latest 977134366673.dkr.ecr.ap-south-1.amazonaws.com/tomcat:latest'
              sh 'docker push 977134366673.dkr.ecr.ap-south-1.amazonaws.com/tomcat:latest'
              sh 'sudo chmod 666 /var/run/docker.sock'
         
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
