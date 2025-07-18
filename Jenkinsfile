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
                    credentialsId: 'github-token', 
                    url: 'https://github.com/oumaimajallouli/oumaima-jallouli-back-repo.git'  // Corrigé ici !
            }
        }
        stage('Debug JDK') {
    steps {
        sh 'java -version'
        sh 'javac -version'
        sh 'mvn --version'
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
