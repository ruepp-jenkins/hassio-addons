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

        URLTrigger(
            cronTabSpec: 'H/30 * * * *',
            labelRestriction: 'urltrigger',
            entries: [
                URLTriggerEntry(
                    url: 'https://raw.githubusercontent.com/ruepp-jenkins/hassio-image-databasus/refs/heads/main/latest_version.txt',
                    contentTypes: [
                        JsonContent(
                            [
                                JsonContentEntry(jsonPath: '$.protected')
                            ]
                        )
                    ]
                )
            ]
        )
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
        stage('Ensure Scripts are Runnable') {
            steps {
                sh 'chmod +x *.sh'
                sh 'chmod +x scripts/*.sh'
            }
        }
        stage('Setup Git') {
            steps {
                sh './setup_git.sh'
            }
        }
        stage('Check Addons') {
            steps {
                    sh './run_scripts.sh'
            }
        }
        stage('Commit Changes') {
            steps {
                withCredentials([sshUserPrivateKey(credentialsId: 'github.com-ssh', keyFileVariable: 'SSH_KEY_FILE')]) {
                    withEnv(['GIT_SSH_COMMAND=ssh -i $SSH_KEY_FILE -o StrictHostKeyChecking=no']) {
                        sh './commit_changes.sh'
                    }
                }
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
