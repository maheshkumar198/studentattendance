# 🚀 Full Stack Deployment (Angular + .NET + MySQL + Nginx)

---

## 🛢️ Database Setup (MySQL)

### 📁 Navigate to Database Folder

```bash
cd Database
```

### ⚙️ Install MySQL

```bash
sudo apt update
sudo apt install mysql-server -y
```

### 🔐 Secure Installation

```bash
sudo mysql_secure_installation
```

### 🧑‍💻 Login to MySQL

```bash
sudo mysql -u root -p
```

### 🏗️ Create Database & User

```sql
CREATE DATABASE studentattendancedb;
CREATE USER 'mahesh'@'%' IDENTIFIED BY 'Techn@1204#';
GRANT ALL PRIVILEGES ON studentattendancedb.* TO 'mahesh'@'%';
FLUSH PRIVILEGES;
```

### 📦 Restore Backup

```bash
mysql -u root -p studentattendancedb < full_backup.sql
```

---

## 🔗 Update Database Configuration (IMPORTANT)

```bash
nano Backend/appsettings.Production.json
```

```json
{
  "ConnectionStrings": {
    "DefaultConnection": "Server=mysql;Database=studentattendancedb;Uid=mahesh;Pwd=Techn@1204#;"
  }
}
```

---

## ⚙️ Backend Setup (.NET API)

### 📁 Navigate to Backend

```bash
cd Backend
```

### 🧹 Clean & Restore

```bash
sudo rm -rf bin/*
sudo dotnet clean
sudo dotnet restore
```

---

## 🔄 Run Backend as a Service (systemd)

### 📦 Publish Application

```bash
sudo dotnet publish -c Release -o /var/www/backend
```

### 📁 Create Service File

```bash
sudo nano /etc/systemd/system/backend.service
```

```ini
[Unit]
Description=Student Attendance API
After=network.target

[Service]
WorkingDirectory=/var/www/backend/StudentAttendance/
ExecStart=/usr/bin/dotnet StudentAttendanceAPI.dll
Restart=always
RestartSec=10
SyslogIdentifier=student-api
User=www-data
Environment=ASPNETCORE_ENVIRONMENT=Production

[Install]
WantedBy=multi-user.target
```

### ▶️ Enable & Start

```bash
sudo systemctl daemon-reexec
sudo systemctl daemon-reload
sudo systemctl enable backend
sudo systemctl start backend
```

---

## 🎨 Frontend Setup (Angular)

### 📁 Navigate to Frontend

```bash
cd Frontend
```

### 🔗 Update API URL

```bash
sudo vim src/environments/environment.prod.ts
```

Update:

```ts
export const environment = {
  production: true,
  apiUrl: '/api/'
};
```

👉 Nginx will handle `/api/` routing to backend.

---

### 📦 Install Dependencies

```bash
sudo npm ci
```

---

### 🛠️ Build Angular App

```bash
sudo npm run build
```

---

### 📁 Copy Build to Nginx

```bash
sudo cp -r dist/* /var/www/html/
```

---

## 🌐 Nginx Setup

* Default web root:

  ```
  /var/www/html
  ```

* Use provided config file from:

  ```
  StudentAttendance/nginx.conf
  ```

### Apply Config

```bash
sudo cp nginx.conf /etc/nginx/sites-available/default
sudo systemctl restart nginx
```



## 👨‍💻 Author

Mahesh Maharana
System Administrator | Cloud & DevOps Learner

---
