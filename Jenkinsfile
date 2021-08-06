node {
    // Checkout from Git
    checkout scm

    // Docker image variables
    def docker_local_registry_host = 'localhost'
    def docker_local_registry_port = '5000'
    def docker_repository_name = 'spring-petclinic'
    def docker_image_name = 'spring-petclinic'
    def docker_image_tag = "${docker_local_registry_host}:${docker_local_registry_port}/${docker_repository_name}/${docker_image_name}:${BRANCH_NAME}_${BUILD_NUMBER}"

    // Build the application and publish test results
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

    // Create Docker image with specific tag for local registry
    stage('Create Docker image') {
        try {
            sh "docker build -t ${docker_image_tag} ."
        } catch (err) {
            error "Failed create Docker image: ${err}"
        }
    }

    // Push the image to the local registry
    stage('Push Docker image to local registry') {
        try {
            sh "docker push ${docker_image_tag}"
            echo 'In case if you need this specific version of the image use the following command: '
            echo "docker pull ${docker_image_tag}"
        } catch (err) {
            error "Failed to push the image to local registry: ${err}"
        }
    }
}
