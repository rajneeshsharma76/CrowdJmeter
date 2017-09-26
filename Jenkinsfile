pipeline {
  agent any
  stages {
    stage('Create New User') {
      steps {
        steps() {
          sh 'bundle update'
          sh 'bundle exec cucumber features'
        }
        
        sh 'echo "Placeholder To Create A New User"'
      }
    }
    stage('Create A Job') {
      steps {
        sh 'echo "Create a job with the new user"'
      }
    }
    stage('Ready For Review') {
      steps {
        echo 'Deploying....'
      }
    }
    stage('Download Reports') {
      steps {
        sh 'echo "Downloading Reports"'
      }
    }
  }
}
