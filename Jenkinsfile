pipeline{
    agent {
        label "jenkins-agent"
    }
    stages {
        stage("Cleanup Workspace") {
            steps {
                cleanWs()
            }
        }

        stage("Checkout from SCM") {
            steps {
                git branch: 'revamp', credentialsId: 'github', url: 'https://github.com/toogoodyshoes/eks-deployment'
            }
        }

        stage("Prepare test suite") {
            steps {
                sh "sudo apt update"
                sh "sudo apt install -y npm"
                sh "npm install --save-dev vitest"
            }
        }

        // stage("Build Docker image for presentation tier") {
        //     steps {
        //         sh "docker build -t resume:v1 ./app/resume/"
        //         sh "docker tag resume:v1 toogoodyshoes/resume:v1"
        //         sh "docker push toogoodyshoes/resume:v1"
        //     }
        // }

        stage("Build Docker image for application tier") {
            steps {
                sh "docker build -t api:v1 ./app/api/"
                sh "docker tag api:v1 toogoodyshoes/api:v1"
                sh "docker push toogoodyshoes/api:v1"
            }
        }
    }
}