pipeline {
    agent any
    stages {
        stage('Clone Repository') {
            steps {
                git 'https://github.com/22008440-LinJingyi/FYPtesting.git'
            }
        }
        stage('Build Docker Containers') {
            steps {
                sh 'docker-compose up -d --build'
            }
        }
        stage('Run Tests') {
            parallel {
                stage('SonarQube Scan') {
                    steps {
                        script {
                            sh 'sonar-scanner'
                        }
                    }
                }
                stage('Dummy Test') {
                    steps {
                        script {
                            sh 'echo "API Test Passed"'
                        }
                    }
                }
            }
        }
        stage('Deploy') {
            steps {
                sh 'docker-compose up -d'
            }
        }
        stage('Approval') {
            steps {
                input 'Do you approve the deployment?'
            }
        }
    }
    post {
        success {
            echo 'Deployment successful!'
        }
    }
}
