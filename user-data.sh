#!/bin/bash
apt update -y
apt install nginx -y

# Декодируем и применяем конфигурацию nginx из template
echo '${nginx_config}' | base64 -d > /etc/nginx/sites-available/default

myip=$(curl -s http://169.254.169.254/latest/meta-data/local-ipv4)
myip_pub=$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4)

echo "<!DOCTYPE html>
<html lang=\"ru\">

<head>
    <meta charset=\"UTF-8\">
    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">
    <title>WebServer Status</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', 'Roboto', sans-serif;
        }

        body {
            background: linear-gradient(135deg, #0f2027 0%, #203a43 50%, #2c5364 100%);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            color: #f5f5f5;
            line-height: 1.6;
            padding: 20px;
        }

        .container {
            background: rgba(255, 255, 255, 0.05);
            backdrop-filter: blur(10px);
            border-radius: 16px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.2);
            padding: 40px;
            text-align: center;
            max-width: 700px;
            width: 100%;
            border: 1px solid rgba(255, 255, 255, 0.1);
        }

        h1 {
            font-weight: 300;
            margin-bottom: 20px;
            color: #3498db;
            font-size: 32px;
            letter-spacing: 1px;
        }

        .server-info {
            text-align: left;
            background: rgba(0, 0, 0, 0.2);
            padding: 25px;
            border-radius: 12px;
            margin-bottom: 20px;
        }

        .config-info {
            text-align: left;
            background: rgba(52, 152, 219, 0.1);
            padding: 20px;
            border-radius: 12px;
            margin-bottom: 25px;
            border-left: 4px solid #3498db;
        }

        .info-item {
            padding: 10px 0;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
            display: flex;
        }

        .info-item:last-child {
            border-bottom: none;
        }

        .label {
            font-weight: 600;
            min-width: 140px;
            color: #ccc;
        }

        .value {
            font-family: 'Fira Mono', monospace;
            color: #2ecc71;
            word-break: break-all;
        }

        .config-value {
            color: #3498db;
        }

        .status-online {
            color: #2ecc71;
        }

        .footer {
            margin-top: 20px;
            color: #95a5a6;
            font-style: italic;
            font-size: 16px;
            padding: 15px;
            border-top: 1px dashed rgba(255, 255, 255, 0.2);
        }

        .logo {
            margin-top: 15px;
            color: #3498db;
            font-size: 14px;
            letter-spacing: 2px;
        }

        @media (max-width: 600px) {
            .container {
                padding: 25px;
            }

            .info-item {
                flex-direction: column;
            }

            .label {
                margin-bottom: 5px;
                min-width: unset;
            }
        }
    </style>
</head>

<body>
    <div class=\"container\">
        <h1>🖥️ WebServer</h1>
        
        <div class=\"server-info\">
            <div class=\"info-item\"><span class=\"label\">Private IP:</span><span class=\"value\">$myip</span></div>
            <div class=\"info-item\"><span class=\"label\">Public IP:</span><span class=\"value\">$myip_pub</span></div>
            <div class=\"info-item\"><span class=\"label\">Status:</span><span class=\"value status-online\">🟢 Online</span></div>
        </div>

        <div class=\"config-info\">
            <div class=\"info-item\"><span class=\"label\">Server Name:</span><span class=\"value config-value\">${server_name}</span></div>
            <div class=\"info-item\"><span class=\"label\">Environment:</span><span class=\"value config-value\">${environment}</span></div>
            <div class=\"info-item\"><span class=\"label\">CPU Cores:</span><span class=\"value config-value\">${cpu_cores}</span></div>
            <div class=\"info-item\"><span class=\"label\">Memory:</span><span class=\"value config-value\">${memory_gb} GB</span></div>
            <div class=\"info-item\"><span class=\"label\">Owner:</span><span class=\"value config-value\">${owner}</span></div>
            <div class=\"info-item\"><span class=\"label\">Project:</span><span class=\"value config-value\">${project}</span></div>
        </div>

        <div class=\"footer\">🚀 Built by Terraform | $(TZ='Europe/Moscow' date +'%d.%m.%Y %H:%M:%S %Z')</div>
        <div class=\"logo\">CLOUD INFRASTRUCTURE</div>
    </div>
</body>

</html>" > /var/www/html/index.html

systemctl enable nginx
systemctl restart nginx