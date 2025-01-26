pipeline {
    agent any

    environment {
        SONAR_HOST = 'http://localhost:9000'
        SONAR_PROJECT_KEY = 'FYPtesting'
        DOCKER_WEB_IMAGE = 'apache-image'
        DOCKER_DB_IMAGE = 'mysql-image'
        WEB_CONTAINER = 'apache-container'
        DB_CONTAINER = 'mysql-container'
        GIT_REPO = 'https://github.com/22018950-LeeHanLin/FinalYearProj.git'
        GIT_USERNAME = 'githubadmin'
        LOG_FOLDER = 'pipeline-logs'
        CONTAINER_FILES_PATH = '/var/lib/jenkins/workspace/container-files' // Full path to container files
        XAMPP_INSTALLER_URL = 'https://sourceforge.net/projects/xampp/files/latest/download'
        XAMPP_INSTALLER_FILE = 'xampp-linux-x64-8.2.12-0-installer.run'
    }

    triggers {
        pollSCM('* * * * *') // Polling every minute
    }

    stages {
        stage('Prepare Environment') {
            steps {
                script {
                    // Ensure container files directory exists
                    sh "mkdir -p ${CONTAINER_FILES_PATH}"

                    // Check if the XAMPP installer is present
                    def installerPath = "${CONTAINER_FILES_PATH}/${XAMPP_INSTALLER_FILE}"
                    if (!fileExists(installerPath)) {
                        echo "Downloading XAMPP installer..."
                        sh """
                        wget ${XAMPP_INSTALLER_URL} -O ${installerPath}
                        chmod +x ${installerPath}
                        chown jenkins:docker ${installerPath}
                        """
                    } else {
                        echo "XAMPP installer already exists at ${installerPath}."
                    }
                }
            }
        }

        stage('Checkout Code') {
            steps {
                script {
                    git branch: 'main',
                    echo "Code checked out from the repository."
                }
            }
        }

        stage('Build and Test Containers') {
            parallel {
                stage('Build Apache Image') {
                    steps {
                        sh "docker build -t ${DOCKER_WEB_IMAGE} -f ${CONTAINER_FILES_PATH}/Dockerfile.web ${CONTAINER_FILES_PATH}"
                        echo "Apache image built: ${DOCKER_WEB_IMAGE}"
                    }
                }
                stage('Build MySQL Image') {
                    steps {
                        sh "docker build -t ${DOCKER_DB_IMAGE} -f ${CONTAINER_FILES_PATH}/Dockerfile.db ${CONTAINER_FILES_PATH}"
                        echo "MySQL image built: ${DOCKER_DB_IMAGE}"
                    }
                }
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

        stage('Deploy Containers') {
            when {
                expression { env.DEPLOY_STATUS == 'good' }
            }
            steps {
                script {
                    echo "Deploying production containers..."
                    sh "docker-compose -f ${CONTAINER_FILES_PATH}/docker-compose.yml up -d"
                }
            }
        }

        stage('Rollback') {
            when {
                expression { env.DEPLOY_STATUS == 'bad' }
            }
            steps {
                sh "${CONTAINER_FILES_PATH}/rollback.sh"
                echo "Rollback executed."
            }
        }
    }

    post {
        success {
            echo 'Pipeline executed successfully!'
        }
        failure {
            echo 'Pipeline failed. Check logs in Jenkins.'
        }
    }
}
