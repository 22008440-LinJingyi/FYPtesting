pipeline {
    agent any

    environment {
        SONAR_HOST = 'http://localhost:9000'
        SONAR_PROJECT_KEY = 'FYPtesting'
        DOCKER_WEB_IMAGE = 'apache-image'
        DOCKER_DB_IMAGE = 'mysql-image'
        WEB_CONTAINER = 'apache-container'
        DB_CONTAINER = 'mysql-container'
        GIT_REPO = 'https://github.com/22008440-LinJingyi/FYPtesting.git'
        CONTAINER_FILES_PATH = '/var/lib/jenkins/workspace/container-files'
        XAMPP_INSTALLER = "${CONTAINER_FILES_PATH}/xampp-linux-x64-8.2.12-0-installer.run"
    }

    stages {
        stage('Prepare Environment') {
            steps {
                script {
                    sh "mkdir -p ${CONTAINER_FILES_PATH}"
                    if (!fileExists(XAMPP_INSTALLER)) {
                        sh """
                        wget -O ${XAMPP_INSTALLER} https://sourceforge.net/projects/xampp/files/latest/download &&
                        chmod +x ${XAMPP_INSTALLER}
                        """
                    } else {
                        echo "XAMPP installer already exists at ${XAMPP_INSTALLER}."
                    }
                }
            }
        }

        stage('Checkout Code') {
            steps {
                script {
                    git branch: 'main',
                        url: "${GIT_REPO}"
                    echo "Code checked out from the repository."
                }
            }
        }

        stage('Build and Test Containers') {
            parallel {
                stage('Build Apache Image') {
                    steps {
                        script {
                            sh "docker build -t ${DOCKER_WEB_IMAGE} -f ${CONTAINER_FILES_PATH}/Dockerfile.web ${CONTAINER_FILES_PATH}"
                            echo "Apache image built successfully."
                        }
                    }
                }
                stage('Build MySQL Image') {
                    steps {
                        script {
                            sh "docker build -t ${DOCKER_DB_IMAGE} -f ${CONTAINER_FILES_PATH}/Dockerfile.db ${CONTAINER_FILES_PATH}"
                            echo "MySQL image built successfully."
                        }
                    }
                }
            }
        }

        stage('Deploy Containers') {
            steps {
                script {
                    try {
                        sh "docker-compose -f ${CONTAINER_FILES_PATH}/docker-compose.yml up -d"
                        echo "Containers deployed successfully."
                    } catch (Exception e) {
                        echo "Deployment failed. Proceeding to rollback."
                        sh "${CONTAINER_FILES_PATH}/rollback.sh"
                    }
                }
            }
        }
    }

    post {
        success {
            echo 'Pipeline executed successfully!'
        }
        failure {
            echo 'Pipeline failed. Check the logs for more details.'
        }
    }
}
