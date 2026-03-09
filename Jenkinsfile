pipeline {
    agent any

    environment {
        IMAGE_NAME = "python-app-image"
        CONTAINER_NAME = "python-app-container"
        REPO_URL = "https://github.com/Tejabhinandan/devops_git_repo.git"
    }

    stages {

        stage('Checkout Code') {
            steps {
                git url: "${REPO_URL}", branch: "main"
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $IMAGE_NAME .'
            }
        }

        stage('Run Docker Container') {
            steps {
                sh 'docker rm -f $CONTAINER_NAME || true'
                sh 'docker run -d -p 8000:8000 --name $CONTAINER_NAME $IMAGE_NAME'
            }
        }

    }
}
