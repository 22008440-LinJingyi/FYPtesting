pipeline {
    agent any

    triggers {
        pollSCM('H/5 * * * *') // Poll GitHub every 5 minutes
    }

    environment {
        SONARQUBE_ENV = credentials('sonarqube-token') // SonarQube authentication token
    }

    stages {
        stage('Source Control') {
            steps {
                echo 'Pulling latest code from GitHub...'
                git branch: 'main', url: ' https://github.com/22008440-LinJingyi/FYPtesting.git'
            }
        }

        stage('Build') {
            steps {
                echo 'Building WAR file...'
                
            }
        }

        stage('Static Code Analysis') {
            steps {
                withSonarQubeEnv('SonarQube') {
                    echo 'Running SonarQube analysis...'
                
                }
            }
        }

        stage('Containerization') {
            steps {
                echo 'Deploying containers...'
                sh '''
                docker-compose up -d
                docker cp build/libs/app.war web-container:/webapps/
                '''
            }
        }

        stage('Approval Gatekeeper') {
            steps {
                script {
                    input message: 'Approve deployment to production?', ok: 'Deploy'
                }
            }
        }

        stage('Testing') {
            parallel {
                stage('SonarQube Quality Gate') {
                    steps {
                        echo 'Validating SonarQube quality gate...'
                        // SonarQube quality gate validation steps here
                    }
                }
                stage('API Testing') {
                    steps {
                        echo 'Running API tests...'
                        sh 'curl -X GET http://localhost:8080/api/test' // Example API test
                    }
                }
            }
        }

        stage('Rollback Mechanism') {
            steps {
                script {
                    echo 'Rollback mechanism placeholder...'
                    // Rollback logic can go here if needed
                }
            }
        }
    }

    post {
        success {
            echo 'Pipeline executed successfully!'
        }
        failure {
            echo 'Pipeline execution failed!'
        }
    }
}
