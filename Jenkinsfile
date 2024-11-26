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



        stage('Deploy') {
            steps {
                script {
                    echo "Deploying application"
                    // Example: Deployment steps to a server
                   
                }
            }
        }
    }

    post {
        always {
            script {
                echo "Pipeline completed"
                // Clean up Docker container and workspace
             
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
