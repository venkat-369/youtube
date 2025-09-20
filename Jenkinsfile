pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "chikkalavenkatasai/youtube-clone:latest"
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
                    sh "docker build -t ${DOCKER_IMAGE} ."
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    script {
                        sh '''
                            echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                            docker push ${DOCKER_IMAGE}
                        '''
                    }
                }
            }
        }

        stage('Deploy Container') {
            steps {
                script {
                    sh '''
                        # Remove old container if it exists
                        docker rm -f youtube-clone || true

                        # Run new container
                        docker run -d -p 8008:80 --name youtube-clone ${DOCKER_IMAGE}
                    '''
                }
            }
        }
    }



