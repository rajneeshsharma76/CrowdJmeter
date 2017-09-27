pipeline {
    agent any

    stages {
        stage('Deploy') {
            steps {
                sh 'scp -r $WORKSPACE/* root@ec2-54-213-139-126.us-west-2.compute.amazonaws.com:/tmp/jmeter/bin/ && ssh -T root@ec2-54-213-139-126.us-west-2.compute.amazonaws.com '/tmp/jmeter/bin/jmeter -n -t load_home_page.jmx &'
            }
        }

    }
}
