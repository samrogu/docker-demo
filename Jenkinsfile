pipeline {
    agent any

    stages {
        stage('build') {
            steps {
                sh 'docker build -t 019290991235.dkr.ecr.us-east-2.amazonaws.com/banco/dockerpy:1.0 .'
            }
        }
        stage('tag') {
            steps {
                sh 'docker tag 019290991235.dkr.ecr.us-east-2.amazonaws.com/banco/dockerpy:1.0 019290991235.dkr.ecr.us-east-2.amazonaws.com/banco/dockerpy:latest'
            }
        }
        stage('login ECR') {
            steps {
                sh 'aws ecr get-login-password --region us-east-2 | docker login --username AWS --password-stdin 019290991235.dkr.ecr.us-east-2.amazonaws.com'
            }
        }
        stage('push') {
            steps {
                sh 'docker push 019290991235.dkr.ecr.us-east-2.amazonaws.com/banco/dockerpy:1.0'
                sh 'docker push 019290991235.dkr.ecr.us-east-2.amazonaws.com/banco/dockerpy:latest'
            }
        }
    }
}