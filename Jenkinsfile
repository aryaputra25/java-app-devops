
pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                sh 'rm -rf build'
                sh 'mkdir -p build'
                sh 'javac -d build Main.java'
            }
        }

        stage('Package') {
            steps {
                sh 'jar cfe build/app.jar Main -C build Main.class'
            }
        }

        stage('Docker Build') {
            steps {
                sh 'docker build -t java-app:jenkins-1 .'
            }
        }

        stage('Deploy') {
            steps {
                sh 'docker compose -p java-app -f compose.yaml up -d --no-deps --force-recreate java-app'
            }
        }

        stage('Validate') {
            steps {
                sh 'curl -f --max-time 10 http://localhost:8081'
                sh 'curl -f --max-time 10 http://localhost:8082'
            }
        }
    }
}

