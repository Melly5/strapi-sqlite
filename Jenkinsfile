pipeline {
    agent any
    stages {
        stage('Debug Env') {
            steps {
                script {
                    sh 'printenv' 
                    def gitUrl = env.GIT_URL ?: "git@gitlab.ru:some/groups/web.git"
                    echo "Полученный воркспейс GitLab: ${( gitUrl =~ /:([^\s]+)\/[^\/]+\.git/)[0][1]}"
                }
            }
        }
        stage('Build Image') {
            steps {
                // Сборка докер-образа страпи
                sh "docker build -t strapi-sqlite:${env.BUILD_NUMBER} ."
            }
        }
        stage('Push to Minikube') {
            steps {
                // Закидываем образ в Minikube, чтобы он его увидел без внешнего реестра
                sh "minikube image load strapi-sqlite:${env.BUILD_NUMBER}"
            }
        }
        stage('Deploy with Helm') {
            steps {
                // Деплой в текущий контекст (Minikube)
                sh "helm upgrade --install strapi ./charts/strapi \
                --set image.tag=${env.BUILD_NUMBER} \
                --set image.pullPolicy=Never"
            }
        }
    }
}

