node {}
    stages {
        stage('Preparation') {
            steps {
                    git 'https://github.com/microservices-demo/carts'
            }
        }
    stage('Build') {
            steps {
                sh 'mvn clean package' 
                
            }
        }
    stage('Test') {
            steps {
                sh 'mvn test' 
                
            }
        }
    stage('Archive') {
            steps {
                archiveArtifacts artifacts: 'target/*.*', fingerprint: true
            }
    }
    
    
    
    
    
    stage('Deploy') {
        
        steps {
        sshPublisher(publishers: [sshPublisherDesc(configName: 'EC2_Linux_CI_Server',
        transfers: [sshTransfer(cleanRemote: true, excludes: '', 
        execCommand: '', 
        execTimeout: 120000, 
        flatten: false, 
        makeEmptyDirs: false, 
        noDefaultExcludes: false, 
        patternSeparator: '[, ]+', 
        remoteDirectory: 'carts/', 
        remoteDirectorySDF: true, 
        removePrefix: '', 
        sourceFiles: '/var/lib/jenkins/workspace/carts/target/carts.jar')], 
        usePromotionTimestamp: true, 
        useWorkspaceInPromotion: false, 
        verbose: false)])
        }
    }
    }
    post {
        always {
            echo 'I have finished and deleting workspace'
            deleteDir() 
        }
        success {
            echo 'Job succeeeded!'
        }
        unstable {
            echo 'I am unstable :/'
        }
        failure {
            echo 'I failed :('
        }
        changed {
            echo 'Things were different before...'
        }
    }
