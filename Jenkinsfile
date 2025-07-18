pipeline {
    agent any

    // Force l'utilisation de JDK 17
    tools {
        jdk 'jdk17'  // Doit correspondre EXACTEMENT au nom dans Jenkins
        maven 'maven3'
    }

    environment {
        // Surcharge des variables pour forcer JDK 17
        JAVA_HOME = "${tool 'jdk17'}"
        PATH = "${tool 'jdk17'}/bin:${env.PATH}"
    }

    stages {
        // Vérification de l'environnement
        stage('🔍 Vérification Java/Maven') {
            steps {
                sh '''
                    echo "=== Version Java ==="
                    java -version
                    echo "=== Version Java Compiler ==="
                    javac -version
                    echo "=== Version Maven ==="
                    mvn --version
                    echo "=== JAVA_HOME ==="
                    echo ${JAVA_HOME}
                '''
            }
        }

        // Étape de build
        stage('🏗 Build') {
            steps {
                sh 'mvn clean install -DskipTests'
            }
        }

        // Étape de test (optionnelle)
        stage('🧪 Tests') {
            steps {
                sh 'mvn test'
            }
        }
    }

    post {
        success {
            echo '✅ Pipeline exécuté avec succès!'
        }
        failure {
            echo '❌ Échec du pipeline. Voir les logs pour détails.'
        }
    }
}
