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

        stage('Verify Java Version') {
            steps {
                script {
                    def javaHome = tool 'JDK17'  // Récupère le chemin de JDK17
                    env.JAVA_HOME = javaHome     // Force JAVA_HOME
                    env.PATH = "${javaHome}/bin:${env.PATH}"  // Ajoute JDK17 au PATH
                    
                    // Vérification
                    sh 'java -version'
                    sh 'javac -version'
                    sh 'mvn --version'
                }
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
