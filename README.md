# 🔐 Gerador de senhas

![Python](https://img.shields.io/badge/Python-3.13-blue)
![Docker](https://img.shields.io/badge/Docker-Ready-2496ED?logo=docker&logoColor=white)
![Redis](https://img.shields.io/badge/Redis-7-red?logo=redis&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-green)

Projeto desenvolvido durante o desafio da LinuxTips com foco na aplicação de boas práticas de Docker e DevSecOps.

O objetivo deste repositório é evoluir uma aplicação Flask utilizando técnicas modernas de containerização, redução de vulnerabilidades e segurança.

---

## 🚀 Tecnologias utilizadas

- Python 3.13
- Flask
- Redis
- Docker

---

## 📂 Estrutura do projeto

```text
.
├── app.py
├── requirements.txt
├── Dockerfile
├── .dockerignore
├── .gitignore
└── README.md
```

---

## ▶️ Como executar

### 1. Criar a rede Docker

```bash
docker network create giropops-net
```

### 2. Executar o Redis

```bash
docker run -d \
  --name redis \
  --network giropops-net \
  redis:7-alpine
```

### 3. Construir a imagem

```bash
docker build -t giropops-password-generator .
```

### 4. Executar a aplicação

```bash
docker run -d \
  --name giropops-app \
  --network giropops-net \
  -p 5000:5000 \
  -e REDIS_HOST=redis \
  giropops-password-generator
```

A aplicação ficará disponível em:

```
http://localhost:5000
```

## 🚀 Evolução do Projeto

Este projeto está sendo desenvolvido em etapas, com foco na adoção de boas práticas de containerização, otimização de imagens e segurança de containers.

### ✅ Etapa 1 – Containerização da aplicação

- Criação do Dockerfile
- Containerização da aplicação Flask
- Execução da aplicação utilizando Docker

### ✅ Etapa 2 – Integração com Redis

- Configuração do Redis como serviço externo
- Comunicação entre containers utilizando Docker Network
- Persistência do contador de acessos

### ✅ Etapa 3 – Docker Multi-stage Build

O Dockerfile foi refatorado utilizando **Docker Multi-stage Build**, separando o ambiente de construção do ambiente de execução da aplicação.

#### Benefícios obtidos

- Redução significativa do tamanho da imagem
- Melhor organização do Dockerfile
- Menor superfície de ataque
- Preparação para utilização de imagens Chainguard

### 📊 Comparativo

| Dockerfile | Tamanho |
|------------|---------:|
| Versão inicial | **1,13 GB** |
| Multi-stage Build | **125 MB** |

**Redução aproximada de 89% no tamanho da imagem.**

---

## 🛣️ Roadmap

- [x] Containerização da aplicação
- [x] Integração com Redis
- [x] Docker Multi-stage Build
- [ ] Migração para imagem Chainguard
- [ ] Análise de vulnerabilidades com Trivy
- [ ] Assinatura de imagens com Cosign
- [ ] Publicação da imagem no GitHub Container Registry (GHCR)


---

## 🎯 Objetivos de aprendizado

Este projeto tem como objetivo praticar:

- Containerização com Docker
- Boas práticas na criação de imagens
- Redução da superfície de ataque
- Segurança de containers

---

## 📚 Créditos

Aplicação baseada no desafio **Giropops Password Generator**, desenvolvido pela LinuxTips.

A evolução deste repositório concentra-se nas práticas de Docker e segurança de containers.
