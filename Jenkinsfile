def secret = 'app'
def server = 'rio@10.119.158.167'
def directory = 'dumbflix-frontend'
def branch = 'main'

pipeline{
    agent any
    stages{
        stage ('docker delete & git pull'){
            steps{
                sshagent([secret]) {
                    sh """ssh -o StrictHostKeyChecking=no ${server} << EOF
                    cd ${directory}
                    docker-compose down
                    docker system prune -f
                    git pull frontend ${branch}
                    exit
                    EOF"""
                }
            }
        }
        stage ('docker compose'){
            steps{
                sshagent([secret]) {
                    sh """ssh -o StrictHostKeyChecking=no ${server} << EOF
                    cd ${directory}
                    docker build -t rioprayogo/dumbflix-fe:v1 .
                    exit
                    EOF"""
                }
            }
        }
        stage ('docker up'){
            steps{
                sshagent([secret]) {
                    sh """ssh -o StrictHostKeyChecking=no ${server} << EOF
                    cd ${directory}
                    docker-compose up -d
                    exit
                    EOF"""
                }
            }
        }
    }
}
