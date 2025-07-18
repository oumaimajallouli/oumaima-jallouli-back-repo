pipeline {

    agent any
 
    tools {

        maven 'Maven3'

        jdk 'JDK17'

    }
 
    environment {

        MAVEN_OPTS = "-Dmaven.test.failure.ignore=true"

        DOCKER_IMAGE = 'mounira111/mounira111'

        VERSION = "${env.BUILD_ID}"

    }
 
    stages {

        stage('Checkout') {

            steps {

                git branch: 'main',

                    credentialsId: 'd5fd6728-1a73-4f91-8408-91a1c4f5ec51',

                    url: 'https://github.com/mouniramohamed/MouniraMed-repo-back.git'

                script {

                    env.GIT_COMMIT_SHORT = sh(returnStdout: true, script: 'git rev-parse --short HEAD').trim()

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
 
        stage('SonarQube Analysis') {

            steps {

                withCredentials([string(credentialsId: 'sonar-token', variable: 'SONAR_TOKEN')]) {

                    withSonarQubeEnv('SonarQube') {

                        sh 'mvn sonar:sonar -Dsonar.token=$SONAR_TOKEN'

                    }

                }

            }

        }
 
        stage('Build Docker Image') {

            steps {

                script {

                    sh """

                        docker build --no-cache \

                            -t ${DOCKER_IMAGE}:latest \

                            -t ${DOCKER_IMAGE}:${VERSION} \

                            -t ${DOCKER_IMAGE}:${env.GIT_COMMIT_SHORT} .

                    """

                }

            }

        }
 
        stage('Push to Docker Hub') {

            steps {

                withCredentials([usernamePassword(

                    credentialsId: 'dockerhub-credential',

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

            echo '✅ Build, Sonar analysis et Docker push réussis !'

        }

        failure {

            echo '❌ Échec du pipeline.'

        }

    }

}
 
