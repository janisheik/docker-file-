pipeline {
    agent any
    environment {
        ECR_REPO = "public.ecr.aws/m8a8q5v2/tomcat"
        AWS_REGION = "ap-south-1"
        EKS_CLUSTER_NAME = "my-eks-cluster"
    }
    stages {
        stage('Clone repository') {
            steps {
                git branch: 'main', url: 'https://github.com/janisheik/docker-file-.git'
            }
        }
        stage('Build and push to ECR') {
            steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-credentials']]) {
                    sh "docker build -t myapp ."
                    sh "aws ecr-public get-login-password --region us-east-1 | docker login --username AWS --password-stdin public.ecr.aws/m8a8q5v2"
                    sh "docker tag tomcat:latest public.ecr.aws/m8a8q5v2/tomcat:latest"
                    sh "docker push public.ecr.aws/m8a8q5v2/tomcat:latest"
                }
            }
        }
        stage('Deploy to EKS') {
            steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-credentials']]) {
                    sh "aws eks update-kubeconfig --name ${EKS_CLUSTER_NAME} --region ${AWS_REGION}"
                    sh "kubectl set image deployment/myapp myapp=${ECR_REPO}:latest"
                }
            }
        }
    }
}
