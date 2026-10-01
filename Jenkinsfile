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

        stage('Deploy') {
            steps {
                sh './deploy.sh'
            }
        }

        stage('Validate') {
            steps {
                sh 'curl -f https://localhost:8081'
            }
        }

    }
}
