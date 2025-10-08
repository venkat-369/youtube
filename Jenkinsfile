pipeline {
    agent any

    environment {
        DOCKER_HUB_CREDENTIALS = 'dockerhub-login' // your Jenkins credentials ID
        IMAGE_NAME = 'chikkalavenkatasai/youtube-clone'
    }

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/venkat-369/youtube.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh "docker build -t ${IMAGE_NAME}:latest ."
            }
        }

        stage('Push Docker Image') {
            steps {
                withCredentials([usernamePassword(credentialsId: "${DOCKER_HUB_CREDENTIALS}", usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh '''
                        echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                        docker push ${IMAGE_NAME}:latest
                    '''
                }
            }
        }

        stage('Deploy Container') {
            steps {
                sh '''
                    docker stop youtube || true
                    docker rm youtube || true
                    docker run -d --name youtube -p 80:80 ${IMAGE_NAME}:latest
                '''
            }
        }
    }
}




