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

        stage("Build Docker image") {
            steps {
                sh "sudo docker build -t demo:v1 /dockerfiles/"
                sh "sudo docker push demo:v1"
            }
        }
    }
}