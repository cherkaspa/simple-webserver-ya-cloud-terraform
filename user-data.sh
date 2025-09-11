#!/bin/bash
apt update -y
apt install nginx -y
myip=$(curl -s http://169.254.169.254/latest/meta-data/local-ipv4)
myip_pub=$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4)
echo "<!DOCTYPE html>
<html lang="ru">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
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
            max-width: 600px;
            width: 100%;
            border: 1px solid rgba(255, 255, 255, 0.1);
        }

        h1 {
            font-weight: 300;
            margin-bottom: 30px;
            color: #3498db;
            font-size: 32px;
            letter-spacing: 1px;
        }

        .server-info {
            text-align: left;
            background: rgba(0, 0, 0, 0.2);
            padding: 25px;
            border-radius: 12px;
            margin-bottom: 30px;
        }

        .info-item {
            padding: 12px 0;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
            display: flex;
        }

        .info-item:last-child {
            border-bottom: none;
        }

        .label {
            font-weight: 600;
            min-width: 120px;
            color: #ccc;
        }

        .value {
            font-family: "Fira Mono", monospace;
            color: #2ecc71;
            word-break: break-all;
        }

        .footer {
            margin-top: 25px;
            color: #95a5a6;
            font-style: italic;
            font-size: 16px;
            padding: 15px;
            border-top: 1px dashed rgba(255, 255, 255, 0.2);
        }

        .logo {
            margin-top: 20px;
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
            }
        }
    </style>
</head>

<body>
    <div class="container">
        <h1>WebServer</h1>
        <div class="server-info">
            <div class="info-item"><span class="label">Private IP:</span><span class="value">$myip</span></div>
            <div class="info-item"><span class="label">Public IP:</span><span class="value">$myip_pub</span></div>
            <div class="info-item"><span class="label">Status:</span><span class="value">🟢 Online</span></div>
        </div>
        <div class="footer">Built by Terraform</div>
        <div class="logo">CLOUD INFRASTRUCTURE</div>
    </div>
</body>

</html>" > /var/www/html/index.html
systemctl enable nginx
systemctl start nginx