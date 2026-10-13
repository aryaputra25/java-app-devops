```groovy
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
                sh '''
                    for i in $(seq 1 10); do
                        if curl -fsS --max-time 3 http://localhost:8081; then
                            echo "Java application is ready"
                            break
                        fi

                        if [ "$i" -eq 10 ]; then
                            echo "Java application validation failed"
                            docker logs --tail 50 java-app-compose
                            exit 1
                        fi

                        echo "Waiting for Java application... ($i/10)"
                        sleep 2
                    done
                '''

                sh 'curl -f --retry 5 --retry-connrefused --retry-delay 2 --max-time 10 http://localhost:8082'
            }
        }
    }
}
```
