pipeline {
    agent any
    stages {
        stage('Debug Env') {
            steps {
                script {
                    // sh 'printenv' 
                    def gitUrl = "git@gitlab.ru:some/groups/web.git"
                    echo "Полученный воркспейс GitLab: ${( gitUrl =~ /:([^\s]+)\/[^\/]+\.git/)[0][1]}"
                }
            }
        }
        // stage('Build Image') {
        //     steps {
        //         // Сборка докер-образа страпи
        //         sh "docker build -t strapi-sqlite:${env.BUILD_NUMBER} ."
        //     }
        // }
        // stage('Push to Minikube') {
        //     steps {
        //         // Закидываем образ в Minikube, чтобы он его увидел без внешнего реестра
        //         sh "minikube image load strapi-sqlite:${env.BUILD_NUMBER}"
        //     }
        // }
        // stage('Deploy with Helm') {
        //     steps {
        //         // Деплой в текущий контекст (Minikube)
        //         sh "helm upgrade --install strapi ./charts/strapi \
        //         --set image.tag=${env.BUILD_NUMBER} \
        //         --set image.pullPolicy=Never"
        //     }
        // }
    }
    post {
        always {
            script {
                def hasAgent = false
                try {
                    // Если агент есть — pwd() вернет путь. Если агента нет — упадет с ошибкой.
                    def currentDir = pwd() 
                    hasAgent = true
                    echo "✅ Агент активен! Текущий воркспейс: ${currentDir}"
                } catch (Exception e) {
                    echo "❌ Агента нет в post. Логическая ошибка: ${e.getMessage()}"
                }

                // Теперь используем результат проверки
                if (hasAgent) {
                    // Здесь можно безопасно вызывать sh 'curl ...'
                    echo "has agent true"
                } else {
                    echo "Предупреждение: Пропускаем вызов функции, так как нет ноды для выполнения."
                }
            }
        }
    }
}