properties(
    [
        githubProjectProperty(
            displayName: 'hassio-addons',
            projectUrlStr: 'https://github.com/ruepp-jenkins/hassio-addons/'
        ),
        disableConcurrentBuilds(abortPrevious: true)
    ]
)

pipeline {
    agent any

    triggers {
        cron('0 3 * * *')  // Run daily at 3:00 AM
    }

    stages {
        stage('Pre Cleanup') {
            steps {
                cleanWs()
            }
        }
        stage('Checkout') {
            steps {
                git branch: env.BRANCH_NAME,
                    credentialsId: 'ruepp-jenkins',
                    url: env.GIT_URL
            }
        }
        stage('Check Addons') {
            steps {
                    sh 'chmod +x run_scripts.sh'
                    sh 'chmod +x scripts/*.sh'
                    sh './run_scripts.sh'
            }
        }
    }

    post {
        always {
            discordSend result: currentBuild.currentResult,
                description: env.GIT_URL,
                link: env.BUILD_URL,
                title: JOB_NAME,
                webhookURL: DISCORD_WEBHOOK
        }
    }
}
