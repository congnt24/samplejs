pipeline {
agent any
stages {
    stage ("Checkout") {
        steps{
            git branch: 'master',
            url: 'https://github.com/congnt24/samplejs.git'
        }
    }
    stage(‘Building’) {
        steps{
          script {
                    dockerImage = docker.build "trungcong24/simplejs2:test"
                  }
             }
        }
  }
}