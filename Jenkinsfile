pipeline {
    agent any

    environment {
        // Node version and paths
        NODE_VERSION = '20'
        WORKSPACE = "${WORKSPACE}"
        
        // Docker configuration
        DOCKER_IMAGE = "smsraj2001/shoe-shop"
        DOCKER_CREDENTIALS = credentials('docker-creds')
        
        // Application secrets
        MONGODB_URI = credentials('mongodb-uri')
        JWT_SECRET = credentials('jwt-secret')
        BRAINTREE_MERCHANT_ID = credentials('braintree-merchant')
        BRAINTREE_PUBLIC_KEY = credentials('braintree-public')
        BRAINTREE_PRIVATE_KEY = credentials('braintree-private')
    }

    stages {
        stage('Clean Workspace') {
            steps {
                bat 'if exist "node_modules" rmdir /s /q node_modules'
                bat 'if exist "client\\node_modules" rmdir /s /q client\\node_modules'
            }
        }

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Setup Environment') {
            steps {
                script {
                    // Write server .env file
                    writeFile file: '.env', text: """
                        MONGODB_URI=${MONGODB_URI}
                        JWT_SECRET=${JWT_SECRET}
                        BRAINTREE_MERCHANT_ID=${BRAINTREE_MERCHANT_ID}
                        BRAINTREE_PUBLIC_KEY=${BRAINTREE_PUBLIC_KEY}
                        BRAINTREE_PRIVATE_KEY=${BRAINTREE_PRIVATE_KEY}
                        NODE_ENV=production
                        PORT=5000
                    """

                    // Write client .env file
                    writeFile file: 'client/.env', text: """
                        REACT_APP_API_URL=https://shoe-shop-ecommerce-web-app.onrender.com/api
                        CI=false
                    """
                }
            }
        }

        stage('Install Dependencies') {
            steps {
                // Install server dependencies
                bat 'npm install'
                
                // Install client dependencies
                dir('client') {
                    bat 'npm install'
                }
            }
        }

        stage('Build Client') {
            steps {
                dir('client') {
                    bat 'npm run build'
                }
            }
        }

        stage('Docker Build & Push') {
            steps {
                script {
                    // Login to Docker Hub
                    bat 'echo %DOCKER_CREDENTIALS_PSW%| docker login -u %DOCKER_CREDENTIALS_USR% --password-stdin'
                    
                    // Build Docker image
                    bat "docker build -t ${DOCKER_IMAGE}:${BUILD_NUMBER} ."
                    bat "docker tag ${DOCKER_IMAGE}:${BUILD_NUMBER} ${DOCKER_IMAGE}:latest"
                    
                    // Push Docker image
                    bat "docker push ${DOCKER_IMAGE}:${BUILD_NUMBER}"
                    bat "docker push ${DOCKER_IMAGE}:latest"
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    // Stop existing containers
                    bat 'docker-compose down || exit 0'
                    
                    // Start new containers
                    bat 'docker-compose up -d'
                }
            }
        }
    }

    post {
        always {
            // Cleanup
            bat 'docker system prune -f'
        }
        success {
            echo 'Pipeline succeeded! Application deployed successfully.'
        }
        failure {
            echo 'Pipeline failed! Check the logs for details.'
        }
    }
}