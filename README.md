*This project has been created as part of the 42 curriculum by Aslan Isaev.*

# 🐳 Inception

## 📌 Description

Inception is a system administration project focused on building a small infrastructure using Docker.

The goal is to set up multiple interconnected services:

* NGINX (with TLS)
* WordPress (with php-fpm)
* MariaDB

Each service runs in its own container and communicates through a Docker network.

---

## ⚙️ Instructions

### 🔧 Build and run

```bash
make up
```

### 🛑 Stop

```bash
make down
```

### 🧹 Clean

```bash
make clean
```

---

## 🏗 Architecture

The infrastructure consists of three main services:

* NGINX → handles HTTPS requests (port 443)
* WordPress → application layer (php-fpm)
* MariaDB → database

All services are connected via a Docker network and use persistent volumes.

---

## 🧠 Technical Choices

### Docker vs Virtual Machines

Docker containers are lightweight and share the host OS kernel, while virtual machines run full operating systems and require more resources.

### Secrets vs Environment Variables

Secrets are safer because they are not exposed in environment variables or logs.

### Docker Network vs Host Network

Docker networks isolate containers and allow secure communication, while host network removes isolation.

### Docker Volumes vs Bind Mounts

Volumes are managed by Docker and safer for production use, while bind mounts depend on the host file system.

---

## 📚 Resources

* Docker documentation
* 42 subject
* Linux man pages

AI (ChatGPT) was used to:

* understand Docker concepts
* structure the project
* generate documentation templates

