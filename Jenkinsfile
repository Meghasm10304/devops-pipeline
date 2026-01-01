pipeline {
    agent any

    environment {
        IMAGE_NAME = "hello-devops"
        CONTAINER_NAME = "hello-devops-container"
    }

    stages {

        stage('Checkout Code') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                sh '''
                echo "Building Docker image..."
                docker --version
                docker build -t $IMAGE_NAME .
                '''
            }
        }

        stage('Run Docker Container') {
            steps {
                sh '''
                echo "Running Docker container..."

                # Stop and remove existing container if present
                docker rm -f $CONTAINER_NAME || true

                # Run new container
                docker run -d \
                  -p 8082:80 \
                  --name $CONTAINER_NAME \
                  $IMAGE_NAME
                '''
            }
        }

        /*
        OPTIONAL — ENABLE LATER (DockerHub push)

        stage('Push Docker Image') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-credentials',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    sh '''
                    echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                    docker tag $IMAGE_NAME $DOCKER_USER/$IMAGE_NAME:latest
                    docker push $DOCKER_USER/$IMAGE_NAME:latest
                    '''
                }
            }
        }
        */
    }

    post {
        success {
            echo "✅ Pipeline executed successfully"
        }
        failure {
            echo "❌ Pipeline failed. Check logs."
        }
    }
}

