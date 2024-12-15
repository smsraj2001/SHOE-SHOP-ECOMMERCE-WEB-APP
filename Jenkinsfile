pipeline {
    agent {
        docker {
            image 'node:20' // Node.js Docker image
        }
    }

    environment {
        NODE_ENV = 'production'
        DOCKER_IMAGE = 'smsraj2001/sms-shoe-shop' // Replace with your Docker Hub username and repository name
    }

    stages {
        stage('Checkout') {
            steps {
                // Clone the repository
                checkout scm
            }
        }

        stage('Install Dependencies') {
            steps {
                sh 'npm install'
                sh 'npm install --prefix client'
            }
        }

        stage('Build React App') {
            steps {
                sh 'npm run build-client'
            }
        }

        stage('Run Tests') {
            steps {
                sh 'npm test --prefix client'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    dockerImage = docker.build("${env.DOCKER_IMAGE}:${env.BUILD_NUMBER}")
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'docker-hub-credentials') {
                        dockerImage.push("${env.BUILD_NUMBER}")
                        dockerImage.push("latest")
                    }
                }
            }
        }

        stage('Deploy') {
            steps {
                // Run the app as a container
                sh 'docker stop sms-shoe-shop || true'
                sh 'docker rm sms-shoe-shop || true'
                sh 'docker run -d --name sms-shoe-shop -p 5000:5000 ${env.DOCKER_IMAGE}:latest'
            }
        }
    }

    post {
        always {
            echo 'Pipeline completed.'
        }
        failure {
            echo 'Pipeline failed.'
        }
    }
}
