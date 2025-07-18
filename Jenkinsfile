pipeline {
    agent any

    tools {
        jdk 'JDK17'           // Nom du JDK configuré dans Jenkins
        maven 'Maven3'        // Nom de Maven configuré dans Jenkins
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
                sh 'mvn clean package'
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
            echo '✅ Build réussi.'
        }
        failure {
            echo '❌ Échec du pipeline.'
        }
    }
}
