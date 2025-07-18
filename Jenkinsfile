pipeline {
    agent any

    tools {
        maven 'Maven3'
        jdk 'JDK17'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main',
                    credentialsId: 'github-token',  // Remplace par ton ID de credential Jenkins si repo privé
                    url: 'https://github.com/oumaimajallouli/oumaima-jouli-back-repo.git'
            }
        }

        stage('Info versions') {
            steps {
                sh 'java -version'
                sh 'mvn -version'
            }
        }

        stage('Build') {
            steps {
                sh 'mvn clean install'
            }
        }

        stage('Test') {
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
