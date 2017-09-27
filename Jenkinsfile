pipeline {
    agent jmeter

    stages {
        stage('run test') {
            steps {
                sh '/opt/jmeter/bin/jmeter -n -t load_home_page.jmx'
            }
        }

    }
}
