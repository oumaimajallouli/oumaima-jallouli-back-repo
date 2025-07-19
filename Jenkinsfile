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

  stage('Build Docker Image') {
            steps {
                sh "docker build -t back:latest ."
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
