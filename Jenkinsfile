pipeline {
    agent any

    tools {
        // Utilisez les noms EXACTS tels qu'ils apparaissent dans Jenkins
        jdk 'JDK17'  // Avec majuscules comme suggéré dans l'erreur
        maven 'Maven3'  // Avec majuscule comme suggéré
    }

    environment {
        // Surcharge pour confirmation
        JAVA_HOME = "${tool 'JDK17'}"
        PATH = "${tool 'JDK17'}/bin:${env.PATH}"
    }

    stages {
        stage('🛠 Vérification Outils') {
            steps {
                sh '''
                    echo "=== JAVA_HOME ==="
                    echo $JAVA_HOME
                    echo "=== Java Version ==="
                    java -version
                    echo "=== Maven Version ==="
                    mvn --version
                '''
            }
        }

        stage('🏗 Build') {
            steps {
                sh 'mvn clean install -DskipTests'
            }
        }
    }

    post {
        always {
            echo "✅ Pipeline terminé - Voir les logs ci-dessus"
        }
    }
}
