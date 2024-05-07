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
                sh "docker build -t demo:v1 ./dockerfiles/"
                sh "docker tag demo:v1 toogoodyshoes/demo:v1"
                sh "docker push toogoodyshoes/demo:v1"
            }
        }
    }
}