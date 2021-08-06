node {
    checkout scm
    stage('Build') {
        try {
            sh './mvnw clean package'
        } catch (err) {
            error "The build failed: ${err}"
        } finally {
            stage('Publish test results') {
                step([$class: 'JUnitResultArchiver', checksName: '', testResults: 'target/surefire-reports/TEST-*.xml'])
            }
        }
    }

    stage('Create Docker image') {
        try {
            def docker_image_tag = "${BRANCH_NAME}_${BUILD_NUMBER}"
            echo ${docker_image_tag}
        } catch {
            error "Failed to create a tag"
        }
    }
}
