pipeline {
    agent any

    environment {
        DOCKER_HUB_CREDENTIALS = 'chikkalavenkatasai'
        IMAGE_NAME = "chikkalavenkatasai/youtube-clone"
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/venkat-369/youtube.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh "docker build -t ${IMAGE_NAME}:latest ."
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    docker.withRegistry('', DOCKER_HUB_CREDENTIALS) {
                        sh "docker push ${IMAGE_NAME}:latest"
                    }
                }
            }
        }

        stage('Deploy Container') {
            steps {
                script {
                    sh "docker run -d --name youtube-clone -p 8088:80 ${IMAGE_NAME}:latest || true"
                }
            }
        }
    }
}




