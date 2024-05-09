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

        stage("Build Docker image for app") {
            steps {
                sh "docker build -t resume:v1 ./app/resume/"
                sh "docker tag resume:v1 toogoodyshoes/resume:v1"
                sh "docker push toogoodyshoes/resume:v1"
            }
        }
    }
}