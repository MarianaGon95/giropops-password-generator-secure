# 🔐 Gerador de senhas

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

---

## 🛣️ Roadmap

- [x] Containerização da aplicação
- [x] Integração com Redis
- [ ] Docker Multi-stage
- [ ] Imagem Chainguard
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
- Supply Chain Security
- Automação de pipelines
- DevSecOps

---

## 📚 Créditos

Aplicação baseada no desafio **Giropops Password Generator**, desenvolvido pela LinuxTips.

A evolução deste repositório concentra-se nas práticas de Docker, DevSecOps e segurança de containers.
