pipeline {
    agent any

    tools {
        maven 'Maven3'
        jdk 'JDK17'  // Doit correspondre exactement au nom dans Jenkins
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main',
                    credentialsId: 'github-token',
                    url: 'https://github.com/oumaimajallouli/oumaima-jallouli-back-repo.git'
            }
        }


        stage('Build') {
            steps {
                sh 'mvn clean install -DskipTests'
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
