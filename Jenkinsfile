pipeline {
    agent jmeter

    stages {
        stage('run test') {
            steps {
                sh 'jmeter -n -t load_home_page.jmx'
            }
        }

    }
}
