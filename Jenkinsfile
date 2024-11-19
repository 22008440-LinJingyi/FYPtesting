pipeline {
    agent any
    stages {
        stage('Clone Repository') {
            steps {
                deleteDir()  // Clean up workspace
                git url: 'https://github.com/22008440-LinJingyi/FYPtesting.git', branch: 'main', credentialsId: 'github-fyp'
                sh 'git status'  // Optional: Check out git status for debugging
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
        failure {
            echo 'Deployment failed.'
        }
        always {
            echo 'Cleaning up after the build.'
        }
    }
}
