properties([
    pipelineTriggers([
        pollSCM('H/5 * * * *') // Adjust schedule as needed, this triggers polling every 5 minutes
    ])
])
pipeline {
    agent any

    stages {
        stage('Clone Repository') {
            steps {
                script {
                    // Clone the GitHub repository
                    git url: 'https://github.com/22008440-LinJingyi/FYPtesting.git', branch: 'main'

                    // Output the current workspace path to confirm the clone
                    echo "Workspace path: ${pwd()}"
                }
            }
        }

        stage('Build') {
            steps {
                script {
                    // Simulate a build process
                    echo "Building the web application"
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                script {
                    echo "Building and running Docker container"
                    
                    // Build Docker image
                    
                    // Run Docker container
                }
            }
        }

        stage('Parallel Testing') {
            parallel {
                stage('Unit Tests') {
                    steps {
                        script {
                            echo "Running Unit Tests"
                            // Simulate running unit tests
                        }
                    }
                }
                stage('Integration Tests') {
                    steps {
                        script {
                            echo "Running Integration Tests"
                            // Simulate running integration tests
                        }
                    }
                }
                stage('Code Quality Analysis') {
                    steps {
                        script {
                            echo "Running SonarQube Analysis"
                            // Simulate SonarQube analysis (replace with actual SonarScanner command)
                        }
                    }
                }
            }
        }

        stage('Approval Gatekeeper') {
            steps {
                script {
                    echo "Simulated approval for testing purposes."
                    // enable manual approval in the future?
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    echo "Deploying application..."
                }
            }
        }
    }

    post {
        always {
            script {
                echo "Pipeline completed"
                cleanWs() // Clean workspace after each run
            }
        }

        success {
            script {
                echo "Pipeline succeeded"
            }
        }

        failure {
            script {
                echo "Pipeline failed"
            }
        }
    }
}
