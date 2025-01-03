pipeline {
    agent any

    environment {
        SONAR_HOST = 'http://localhost:9000'
        SONAR_PROJECT_KEY = 'FYPtesting'
        DOCKER_IMAGE = 'fyp-app:1.0'
        DOCKER_CONTAINER = 'fyp-app-container'
        GIT_REPO = 'https://github.com/22008440-LinJingyi/FYPtesting.git'
        LOG_FOLDER = 'pipeline-logs'
    }

    tools {
        sonar 'SonarScanner' // The SonarScanner tool configured in Jenkins
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', url: "${GIT_REPO}"
                echo "Code checked out from the repository."
            }
        }

        stage('Run Parallel Tests') {
            parallel {
                stage('Run SonarQube Analysis') {
                    steps {
                        script {
                            withSonarQubeEnv('SonarQube') {
                                sh 'sonar-scanner -Dsonar.projectKey=${SONAR_PROJECT_KEY} -Dsonar.host.url=${SONAR_HOST}'
                            }
                        }
                    }
                }

                stage('Dummy API Test') {
                    steps {
                        echo "Running dummy API test..."
                        sh "curl -X GET http://localhost:8080/health || true"
                        echo "Dummy API test completed."
                    }
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                sh "docker build -t ${DOCKER_IMAGE} ."
                echo "Docker image built: ${DOCKER_IMAGE}"
            }
        }

        stage('Gatekeeper Approval') {
            steps {
                script {
                    def deployStatus = input message: 'Proceed to deploy or rollback?', ok: 'Proceed', parameters: [
                        choice(name: 'DEPLOY_STATUS', choices: ['good', 'bad'], description: 'Deployment Status')
                    ]
                    env.DEPLOY_STATUS = deployStatus
                }
            }
        }

        stage('Deploy or Rollback') {
            steps {
                script {
                    if (env.DEPLOY_STATUS == 'good') {
                        echo "Deployment approved. Proceeding..."
                        sh """
                        docker stop ${DOCKER_CONTAINER} || true
                        docker rm ${DOCKER_CONTAINER} || true
                        docker run -d --name ${DOCKER_CONTAINER} -p 8080:80 ${DOCKER_IMAGE}
                        """
                        echo "Container deployed: ${DOCKER_CONTAINER}"
                    } else {
                        echo "Rollback initiated."
                        sh './rollback.sh'
                    }
                }
            }
        }

        stage('Clean Old Containers') {
            steps {
                sh './cleanup-containers.sh'
                echo "Old containers and networks cleaned."
            }
        }

        stage('Log Results to GitHub') {
            steps {
                script {
                    sh """
                    mkdir -p ${LOG_FOLDER}
                    echo 'Pipeline execution log' > ${LOG_FOLDER}/log.txt
                    git config --global user.email "you@example.com"
                    git config --global user.name "Your Name"
                    git add ${LOG_FOLDER}
                    git commit -m 'Pipeline logs updated'
                    git push
                    """
                    echo "Logs uploaded to GitHub."
                }
            }
        }
    }

    post {
        success {
            echo 'Pipeline executed successfully!'
        }
        failure {
            echo 'Pipeline failed. Check logs in GitHub.'
        }
    }
}
