def secret = 'admin1'
def server = 'admin1@103.37.124.70'
def directory = 'dumbplay-frontend'
def branch = 'master'
def container = 'dumbplay-fe'


pipeline{
    agent any

    stages{
        stage ('delete & git pull'){
            steps{
                sshagent([secret]) {
                    sh """ssh -o StrictHostKeyChecking=no ${server} << EOF
                    cd ${directory}
                    docker-compose stop ${container}
                    docker container prune -f
                    git pull origin ${branch}
                    exit
                    EOF"""
                }
            }
        }
        stage ('dockerize app'){
            steps{
                sshagent([secret]) {
                    sh """ssh -o StrictHostKeyChecking=no ${server} << EOF
                    cd ${directory}
                    docker build -t kazamisei98/dumbplay-fe-slim:0.1 .
                    exit
                    EOF"""
                }
            }
        }
        stage ('deploy app '){
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

           stage ('upload image to dockerhub '){
            steps{
                sshagent([secret]) {
                    sh """ssh -o StrictHostKeyChecking=no ${server} << EOF
                    cd ${directory}
                    docker push kazamisei98/dumbplay-fe-slim:0.1
                    exit
                    EOF"""
                }
            }
        }


        stage('Push Notification ') {

steps {

     sshagent([secret]) {
                    sh """ssh -o StrictHostKeyChecking=no ${server} << EOF
                    curl -s -X POST https://api.telegram.org/bot6033722165:AAFqBd0-IxtZW4MacIekfTvzql1qLdRCbCk/sendMessage -d chat_id=6192024733 -d text='Build Frontend Complete Bang'
                    EOF"""

                }
    }   
}
    }
}