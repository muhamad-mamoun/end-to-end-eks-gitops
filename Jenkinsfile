pipeline {
    agent {
        kubernetes {
            yaml """
apiVersion: v1
kind: Pod
metadata:
  name: kaniko
spec:
  serviceAccountName: aws-ecr-write-sa
  containers:
    - name: kaniko
      imagePullPolicy: IfNotPresent
      image: gcr.io/kaniko-project/executor:debug
      command:
        - /busybox/cat
      tty: true
  restartPolicy: Never
"""
        }
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/muhamad-mamoun/full-stack-todo-list-app.git']])
            }
        }
        
        stage('Frontend CI') {
            steps {
                container('kaniko') {
                    script {
                        sh """
                        /kaniko/executor --dockerfile `pwd`/frontend/Dockerfile \
                                         --context `pwd`/frontend \
                                         --destination=729798775365.dkr.ecr.us-east-1.amazonaws.com/frontend:v1.${env.BUILD_NUMBER}
                        """
                    }
                }
            }
        }
        
        stage('Backend CI') {
            steps {
                container('kaniko') {
                    script {
                        sh """
                        /kaniko/executor --dockerfile `pwd`/backend/Dockerfile \
                                         --context `pwd`/backend \
                                         --destination=729798775365.dkr.ecr.us-east-1.amazonaws.com/backend:v1.${env.BUILD_NUMBER}
                        """
                    }
                }
            }
        }
    }
}