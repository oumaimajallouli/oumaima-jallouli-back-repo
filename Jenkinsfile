pipeline {
    agent any

    tools {
        jdk 'JDK17'
        maven 'Maven3'
    }

    environment {
        JAVA_HOME = "${tool 'jdk17'}"
        PATH = "${JAVA_HOME}/bin:${env.PATH}"
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main',
                    credentialsId: 'github-token',
                    url: 'https://github.com/oumaimajallouli/oumaima-jallouli-back-repo.git'
            }
        }

        stage('Build with Maven') {
            steps {
                sh 'java -version'
                sh 'mvn clean install -DskipTests'
            }
        }

        stage('Run Tests') {
            steps {
                sh 'mvn test'
            }
        }
    }

    post {
        success {
            echo '✅ Build et tests réussis !'
        }
        failure {
            echo '❌ Échec du pipeline.'
        }
    }
}
