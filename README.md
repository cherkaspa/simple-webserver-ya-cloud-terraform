# Simple Webserver on Yandex Cloud (Terraform)

Terraform модуль для автоматического развертывания простого Nginx веб-сервера в инфраструктуре Yandex Cloud. Этот проект демонстрирует принципы Infrastructure as Code (IaC).

## 🚀 Features

- **Infrastructure as Code**: Полностью описывает инфраструктуру в коде (VPC, подсеть, ВМ, группы безопасности)
- **Automated Provisioning**: Автоматическая установка и настройка Nginx с помощью `cloud-init`
- **Network Setup**: Автоматическое создание VPC сети и подсети
- **Security**: Настройка Security Group для доступа по HTTP/HTTPS
- **Outputs**: Возвращает публичный и приватный IP адреса созданного сервера

## ⚙️ Prerequisites

Перед использованием убедитесь, что у вас установлено и настроено:

1.  **Terraform** >= 1.0.0 ([Installation guide](https://yandex.cloud/ru/docs/tutorials/infrastructure-management/terraform-quickstart))
2.  **Yandex Cloud Account** с активированным аккаунтом и платежным аккаунтом
3.  **YC CLI** настроенный и аутентифицированный, либо:
4.  **Environment Variables** для аутентификации:
5.  **Service Account** создайте сервисный аккаунт с ролью editor. Скопируйте его идентификатор.
    ```bash
    export YC_TOKEN=$(yc iam create-token --impersonate-service-account-id   <идентификатор_сервисного_аккаунта>)
    export YC_CLOUD_ID=$(yc config get cloud-id)
    export YC_FOLDER_ID=$(yc config get folder-id)
    ```

## 🚀 Quick Start

### 1. Clone the Repository

```bash
git clone https://github.com/cherkaspa/simple-webserver-ya-cloud-terraform.git
cd simple-webserver-ya-cloud-terraform
```

### 2. Initialize Terraform

```bash
terraform init
```

### 3. Review Execution Plan

```bash
terraform plan
```

### 4. Apply Configuration

```bash
terraform apply
```

Подтвердите развертывание, введя `yes`. После завершения Terraform выведет публичный IP адрес вашего веб-сервера.

### 5. Verify Deployment

Откройте в браузере полученный публичный IP адрес. Вы должны увидеть страницу с информацией о IP-адресах сервера.

## 🧹 Cleanup

Чтобы избежать непредвиденных расходов, уничтожьте созданную инфраструктуру:

```bash
terraform destroy
```

## 📊 Outputs

После успешного применения конфигурации Terraform выведет:

- `web_server_public_ip` - Публичный IP адрес для доступа к веб-серверу
- `web_server_private_ip` - Приватный IP адрес в сети VPC

## 🤝 Contributing

Это учебный проект. Вклады приветствуются в виде:
- Issue reports
- Suggestions for improvements
- Pull requests

## 📄 License

Этот проект распространяется под лицензией MIT. См. файл [LICENSE](LICENSE) для подробностей.