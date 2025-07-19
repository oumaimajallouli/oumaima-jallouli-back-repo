pipeline {
    agent any

    tools {
        jdk 'JDK17'
        maven 'Maven3'
    }

    environment {
        DOCKER_IMAGE = 'oumaimajallouli/oumaima-app'
        VERSION = '1.0.0'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main',
                    credentialsId: 'github-token',
                    url: 'https://github.com/oumaimajallouli/oumaima-jallouli-back-repo.git'
            }
        }

        stage('Set Git Commit Short') {
            steps {
                script {
                    env.GIT_COMMIT_SHORT = sh(
                        script: "git rev-parse --short HEAD",
                        returnStdout: true
                    ).trim()
                }
            }
        }

        stage('Build with Maven') {
            steps {
                sh 'mvn clean package'
            }
        }

        stage('Run Tests') {
            steps {
                sh 'mvn test'
            }
        }

        stage('Install Docker') {
            steps {
                sh '''
                    if ! [ -x "$(command -v docker)" ]; then
                        echo "🛠️ Docker n'est pas installé, installation en cours..."
                        apt-get update
                        apt-get install -y ca-certificates curl gnupg
                        install -m 0755 -d /etc/apt/keyrings
                        curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
                        chmod a+r /etc/apt/keyrings/docker.gpg
                        echo \
                          "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
                          $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
                        apt-get update
                        apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
                    else
                        echo "✅ Docker déjà installé."
                    fi
                '''
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh """
                        docker build -t ${DOCKER_IMAGE}:latest .
                        docker tag ${DOCKER_IMAGE}:latest ${DOCKER_IMAGE}:${VERSION}
                        docker tag ${DOCKER_IMAGE}:latest ${DOCKER_IMAGE}:${env.GIT_COMMIT_SHORT}
                    """
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'docker-token',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    script {
                        sh """
                            echo "${DOCKER_PASS}" | docker login -u "${DOCKER_USER}" --password-stdin
                            docker push ${DOCKER_IMAGE}:latest
                            docker push ${DOCKER_IMAGE}:${VERSION}
                            docker push ${DOCKER_IMAGE}:${env.GIT_COMMIT_SHORT}
                        """
                    }
                }
            }
        }
    }

    post {
        success {
            echo '✅ Build et Docker push réussis !'
        }
        failure {
            echo '❌ Échec du pipeline.'
        }
    }
}
