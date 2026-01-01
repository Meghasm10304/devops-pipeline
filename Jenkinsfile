pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = 'dockerhub-credentials' // Jenkins credential ID
        IMAGE_NAME = 'meghasm10304/hello-devops'
    }

    stages {
        stage('Checkout') {
            steps {
		git branch: 'main',
                url: 'https://github.com/Meghasm10304/devops-pipeline.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    dockerImage = docker.build("${IMAGE_NAME}:${env.BUILD_NUMBER}")
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('', "${DOCKERHUB_CREDENTIALS}") {
                        dockerImage.push()
                    }
                }
            }
        }

        stage('Run Container') {
            steps {
                script {
                    // Stop old container if exists
                    sh "docker rm -f hello-devops || true"
                    // Run new container
                    sh "docker run -d --name hello-devops -p 3000:3000 ${IMAGE_NAME}:${env.BUILD_NUMBER}"
                }
            }
        }
    }
}

