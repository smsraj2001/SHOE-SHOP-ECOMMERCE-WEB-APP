pipeline {
    agent any

    environment {
        // Node version and paths
        NODE_VERSION = '20'
        WORKSPACE = "${WORKSPACE}"
        
        // Docker configuration
        DOCKER_IMAGE = "smsraj2001/shoe-shop"
        
        // Loading credentials into environment variables
        DOCKER_CREDENTIALS = credentials('docker-creds')
        GITHUB_CREDENTIALS = credentials('github-creds')
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
                bat 'if exist "client\\build" rmdir /s /q client\\build'
            }
        }

        stage('Checkout') {
            steps {
                git credentialsId: 'github-creds', 
                    url: 'https://github.com/smsraj2001/SHOE-SHOP-ECOMMERCE-WEB-APP'
            }
        }

        stage('Setup Environment') {
            steps {
                script {
                    writeFile file: '.env', text: """MONGODB_URI=${MONGODB_URI}
JWT_SECRET=${JWT_SECRET}
BRAINTREE_MERCHANT_ID=${BRAINTREE_MERCHANT_ID}
BRAINTREE_PUBLIC_KEY=${BRAINTREE_PUBLIC_KEY}
BRAINTREE_PRIVATE_KEY=${BRAINTREE_PRIVATE_KEY}
NODE_ENV=production
PORT=5000"""

                    writeFile file: 'client/.env', text: """REACT_APP_API_URL=https://shoe-shop-ecommerce-web-app.onrender.com/api
DISABLE_ESLINT_PLUGIN=true
CI=false"""
                }
            }
        }

        stage('Install Dependencies') {
            steps {
                bat 'npm install'
                dir('client') {
                    bat 'npm install'
                    bat 'npm install --save-dev @babel/plugin-proposal-private-property-in-object'
                }
            }
        }

        stage('Lint Check') {
            steps {
                dir('client') {
                    bat 'npm run lint --if-present || exit 0'
                }
            }
        }

        stage('Build Client') {
            steps {
                dir('client') {
                    withEnv(['CI=false', 'GENERATE_SOURCEMAP=false']) {
                        bat 'npm run build'
                    }
                }
            }
        }

        stage('Docker Build & Push') {
            steps {
                script {
                    // Using the stored Docker credentials
                    withCredentials([usernamePassword(credentialsId: 'docker-creds', passwordVariable: 'DOCKER_PASSWORD', usernameVariable: 'DOCKER_USERNAME')]) {
                        bat "echo %DOCKER_PASSWORD% | docker login -u %DOCKER_USERNAME% --password-stdin"
                        
                        // Build Docker image with properly escaped Windows batch syntax
                        bat """
                            docker build --no-cache ^
                            --build-arg MONGODB_URI=%MONGODB_URI% ^
                            --build-arg JWT_SECRET=%JWT_SECRET% ^
                            --build-arg BRAINTREE_MERCHANT_ID=%BRAINTREE_MERCHANT_ID% ^
                            --build-arg BRAINTREE_PUBLIC_KEY=%BRAINTREE_PUBLIC_KEY% ^
                            --build-arg BRAINTREE_PRIVATE_KEY=%BRAINTREE_PRIVATE_KEY% ^
                            -t %DOCKER_IMAGE%:%BUILD_NUMBER% .
                        """
                        
                        bat "docker tag %DOCKER_IMAGE%:%BUILD_NUMBER% %DOCKER_IMAGE%:latest"
                        bat "docker push %DOCKER_IMAGE%:%BUILD_NUMBER%"
                        bat "docker push %DOCKER_IMAGE%:latest"
                    }
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    try {
                        bat 'docker-compose down'
                    } catch (Exception e) {
                        echo 'No existing containers to stop'
                    }
                    bat 'docker-compose up -d'
                }
            }
        }
    }

    post {
        always {
            bat 'docker system prune -f'
            cleanWs(
                cleanWhenNotBuilt: false,
                deleteDirs: true,
                disableDeferredWipeout: true,
                notFailBuild: true
            )
        }
        success {
            echo 'Pipeline succeeded! Application deployed successfully.'
        }
        failure {
            echo 'Pipeline failed! Check the logs for details.'
        }
    }
}