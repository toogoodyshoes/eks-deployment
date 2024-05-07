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
                git branch: 'jenkins', credentialsId: 'github', url: 'https://github.com/toogoodyshoes/eks-deployment'
            }
        }
    }
}