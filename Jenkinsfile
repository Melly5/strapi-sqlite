pipeline {
    agent any
    stages {
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
                sh "helm upgrade --install strapi ./charts/strapi --set image.tag=${env.BUILD_NUMBER}\
                --set image.tag=5 \
                --set image.pullPolicy=Never"
            }
        }
        stage('Backup with Velero') {
            steps {
                // Создаем бэкап вручную или проверяем расписание
                sh "velero backup create strapi-backup-${env.BUILD_NUMBER} --include-namespaces default"
            }
        }
    }
}

