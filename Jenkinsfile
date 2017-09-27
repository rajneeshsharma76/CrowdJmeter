pipeline {
    agent any

    stages {
        stage('Deploy') {
            steps {
                sh 'scp -r $WORKSPACE/* root@localhost:/tmp/jmeter/bin/'
                sh 'ssh -T root@localhost /tmp/jmeter/bin/jmeter -n -t load_home_page.jmx -l /tmp/jmeter/result.jtl &'
            }
        }

    }
}
