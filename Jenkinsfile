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
                    curl -s -X POST https://api.telegram.org/bot6227949207:AAGbLz03ycwf8Yz1G7wKFzESLkskbkgxeew/sendMessage -d chat_id=5239244706 -d text='Build Complete Bang'
                    EOF"""

                }
    }   
}

post {
    always {
    discordSend description: '', enableArtifactsList: true, footer: '', image: 'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.sonora.id%2Fread%2F423523563%2Farti-yowai-mo-dalam-bahasa-jepang-kata-populer-yang-diungkapkan-gojo-satoru-dalam-anime-jujutsu-kaisen&psig=AOvVaw1gtM_y9PGrSbf_WCgIik6O&ust=1676019705673000&source=images&cd=vfe&ved=0CBAQjRxqFwoTCNiVuoyKiP0CFQAAAAAdAAAAABAc', link: 'https://github.com/KazamiHazaki/Dumbways-FinalTask', result: '', scmWebUrl: '', showChangeset: true, thumbnail: '', title: 'Wayshub-app', webhookURL: 'https://discord.com/api/webhooks/1055488071665188934/yppYX92F1vt_HPuQ6uDFMmCn1PA8MRJ1GeoZuS8TE4CO289bZGT7L2TjDpRiFDCcGFmO'
    }
     }

    }
}