pipeline {
agent any

environment {
IMAGE_NAME = "nageshdocker25/myapp"
IMAGE_TAG = "${env.BUILD_ID}"
FULL_IMAGE = "${IMAGE_NAME}:${IMAGE_TAG}"
}

options {
timestamps()
skipDefaultCheckout()
}

stages {
stage('Checkout Code') {
  steps {
    echo "[INFO] Checking out develop branch..."
    checkout scm
  }
}

stage('Build & Push Docker Image') {
  steps {
    echo "[INFO] Executing Docker build and push..."
    sh '''
      chmod +x scripts/build_and_push.sh
      ./scripts/build_and_push.sh
    '''
  }
}

stage('Apply Infrastructure with Terraform') {
  steps {
    dir('infra') {
      sh '''
        echo "[INFO] Initializing Terraform..."
        terraform init

        echo "[INFO] Applying infrastructure to AWS ap-south-1..."
        terraform apply -auto-approve
      '''
    }
  }
}

stage('Deploy to EC2 with Ansible') {
  steps {
    sh '''
      echo "[INFO] Starting Ansible deployment to EC2..."
      ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i ansible/hosts.ini ansible/deploy.yml
    '''
  }
}
}

post {
success {
echo "[✔] Pipeline executed successfully!"
}
failure {
  echo "[✖] Pipeline failed. Please check the console output for errors."
}

cleanup {
  echo "[INFO] Performing Docker cleanup..."
  sh '''
    chmod +x scripts/cleanup.sh
    ./scripts/cleanup.sh
  '''
}
}
}
