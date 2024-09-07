pipeline {
    agent {
        label 'frontend-node' // Menggunakan agen dengan label 'frontend-node'
    }

    environment {
        SLACK_CHANNEL = '#jenkins'
        SLACK_CREDENTIAL_ID = 'slack-notification'
        GITHUB_CREDENTIALS_ID = 'github-credentials'
        DOCKER_CREDENTIALS_ID = 'dockerhub-credentials'
    }

    triggers {
        pollSCM('* * * * *') // Polling SCM setiap menit
    }

    stages {
        stage('Checkout') {
            steps {
                checkout([
                    $class: 'GitSCM',
                    branches: [[name: '*/main']],
                    userRemoteConfigs: [[
                        url: 'git@github.com:faisalnuriman/pradevops-frontend-dumbflix.git',
                        credentialsId: "${GITHUB_CREDENTIALS_ID}"
                    ]]
                ])
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    VERSION = sh(script: 'git rev-parse HEAD', returnStdout: true).trim()
                    sh "docker build -t faisalnuriman/frontend-pradevops:${VERSION} -f Dockerfile ."
                }
            }
        }
        stage('Push to Docker Hub') {
            steps {
                script {
                    withDockerRegistry([credentialsId: "${DOCKER_CREDENTIALS_ID}", url: 'https://index.docker.io/v1/']) {
                        sh "docker tag faisalnuriman/frontend-pradevops:${VERSION} faisalnuriman/frontend-pradevops:latest"
                        sh "docker push faisalnuriman/frontend-pradevops:${VERSION}"
                        sh "docker push faisalnuriman/frontend-pradevops:latest"
                    }
                }
            }
        }
        stage('Deploy to Server') {
            steps {
                script {
                    sh '''
                    docker stop pradevops-frontend-dumbflix-container-new || true
                    docker rm pradevops-frontend-dumbflix-container-new || true
                    docker pull faisalnuriman/frontend-pradevops:latest
                    docker run -d --name pradevops-frontend-dumbflix-container-new -p 3000:3000 faisalnuriman/frontend-pradevops:latest
                    '''
                }
            }
        }
    }

    post {
        success {
            slackSend(
                channel: env.SLACK_CHANNEL,
                message: "Pipeline sukses: ${env.JOB_NAME} #${env.BUILD_NUMBER} dengan version = ${VERSION}",
                tokenCredentialId: env.SLACK_CREDENTIAL_ID
            )
        }
        failure {
            slackSend(
                channel: env.SLACK_CHANNEL,
                message: "Pipeline gagal: ${env.JOB_NAME} #${env.BUILD_NUMBER}",
                tokenCredentialId: env.SLACK_CREDENTIAL_ID
            )
        }
        unstable {
            slackSend(
                channel: env.SLACK_CHANNEL,
                message: "Pipeline tidak stabil: ${env.JOB_NAME} #${env.BUILD_NUMBER}",
                tokenCredentialId: env.SLACK_CREDENTIAL_ID
            )
        }
    }
}
