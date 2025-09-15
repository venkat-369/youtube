pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "venkat369/youtube-clone:latest"
    }

    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/venkat-369/youtube.git', branch: 'main'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh 'docker build -t $DOCKER_IMAGE .'
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    script {
                        sh """
                        echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin
                        docker push $DOCKER_IMAGE
                        """
                    }
                }
            }
        }

        stage('Deploy Container') {
            steps {
                script {
                    sh 'docker run -d -p 8080:80 --name youtube-clone $DOCKER_IMAGE'
                }
            }
        }
    }
}

