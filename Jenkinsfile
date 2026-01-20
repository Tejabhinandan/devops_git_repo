pipeline {
    agent { label 'git_pipeline' }
    
    options {
        timestamps()
    }
    
    environment {
        GIT_REPO = 'https://github.com/Tejabhinandan/devops_git_repo.git'
        BRANCH = 'main'
    }
    
    stages {
        stage('Checkout repo') {
            steps {
                git branch: BRANCH,
                    url: GIT_REPO,
                    credentialsId: '10efe33f-449e-4b54-8f94-ef5c5e0df665'
            }
        }
        stage('Prepare tools') {
            steps {
                echo 'Installing required tools on ubuntu...'
                sh '''
                    set -e
                    
                    sudo apt-get update -y
                    
                    sudo apt-get install -y \
                        python3 \
                        cmake \
                        python3-pip \
                        curl
                    sudo apt-get install -y pipx
                    pipx install cmakelint
                '''
            }
        }
        stage('Lint') {
            steps {
                echo 'Running lint checks'
                sh '''
                    export PATH=$PATH:/home/ubuntu/.local/bin

                    echo "Running lint checks"
                    which cmakelint || echo "cmakelint not in PATH"
                    cmakelint --version

                    cmakelint CMakeLists.txt > lint_report.txt 2>&1 || true

                    echo "Lint report generated:"
                    cat lint_report.txt
                '''
            }
            post {
                always {
                    archiveArtifacts artifacts: 'lint_report.txt', fingerprint: true
                }
            }
        }
        stage('Build') {
            steps {
                echo 'Running build with CMake...'
                sh '''
                    if [ -f CMakeLists.txt ]; then
                        mkdir -p build
                        cd build
                        cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON ..
                        make -j$(nproc)
                        cp compile_commands.json ..
                    else
                        echo "CMakeLists.txt not found!"
                        exit 1
                    fi
                '''
            }
        }
        stage('Unit Tests') {
            steps {
                sh '''
                    cd build
                    ctest --output-on-failure --test-output-junit test-results.xml || true
                '''
            }
            post {
                always {
                    junit allowEmptyResults: true, testResults: 'build/test-results.xml'
                }
            }
        }
    }
}
