pipeline {
    agent any

    environment {
        DOCKER_USER = "tejabhinandann"
    }

    stages {

        stage('Clone Repository') {
            steps {
                git branch: 'main', url: 'https://github.com/Tejabhinandan/devops_git_repo.git'
            }
        }

        stage('Build Docker Images') {
            steps {
                sh '''
                docker build -t $DOCKER_USER/app1-python ./app1-python
                docker build -t $DOCKER_USER/app2-node ./app2-node
                docker build -t $DOCKER_USER/app3-nginx ./app3-nginx
                docker build -t $DOCKER_USER/app4-java ./app4-java
                docker build -t $DOCKER_USER/app5-go ./app5-go
                '''
            }
        }

        stage('Run Containers') {
            steps {
                sh '''
                docker run -d -p 5001:5000 $DOCKER_USER/app1-python
                docker run -d -p 5002:3000 $DOCKER_USER/app2-node
                docker run -d -p 5003:80 $DOCKER_USER/app3-nginx
                docker run -d -p 5004:8080 $DOCKER_USER/app4-java
                docker run -d -p 5005:8080 $DOCKER_USER/app5-go
                '''
            }
        }

        stage('Docker Login') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub',
                    usernameVariable: 'USERNAME',
                    passwordVariable: 'PASSWORD'
                )]) {
                    sh 'echo $PASSWORD | docker login -u $USERNAME --password-stdin'
                }
            }
        }

        stage('Push Images') {
            steps {
                sh '''
                docker push $DOCKER_USER/app1-python
                docker push $DOCKER_USER/app2-node
                docker push $DOCKER_USER/app3-nginx
                docker push $DOCKER_USER/app4-java
                docker push $DOCKER_USER/app5-go
                '''
            }
        }

    }
}
