pipeline {
    agent any

    stages {
        stage('run test') {
            steps {
                sh '/opt/jmeter/bin/jmeter -n -t Test.jmx'
            }
        }

    }
}
