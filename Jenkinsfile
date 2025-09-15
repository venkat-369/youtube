pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-creds')   // Jenkins credentials ID
        DOCKER_IMAGE = "venkat369/youtube-clone"                 // Change to your DockerHub repo
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
                    sh "docker build -t $DOCKER_IMAGE:latest ."
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    sh "echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin"
                    sh "docker push $DOCKER_IMAGE:latest"
                }
            }
        }

        stage('Deploy Container') {
            steps {
                script {
                    // Stop old container if running
                    sh "docker rm -f youtube-container || true"
                    // Run new container on port 8080
                    sh "docker run -d --name youtube-container -p 8080:80 $DOCKER_IMAGE:latest"
                }
            }
        }
    }
}

