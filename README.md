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
├── sbom.json
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

### ✅ Etapa 4 – Migração para Chainguard

O Dockerfile foi atualizado para utilizar **Chainguard Images**, mantendo a estratégia de **Docker Multi-stage Build** e separando o ambiente de construção do ambiente de execução da aplicação.

#### Benefícios obtidos

- Utilização de imagens minimalistas
- Redução da superfície de ataque
- Separação entre ambiente de build e runtime
- Imagem final menor
- Utilização de ambiente virtual Python (`venv`)
- Remoção da imagem `-dev` do ambiente final

### 📊 Comparativo

| Dockerfile | Tamanho |
| ---------- | -------: |
| Versão inicial | **1,13 GB** |
| Multi-stage Build | **125 MB** |
| Chainguard | **85,8 MB** |

**Redução aproximada de 92% no tamanho da imagem em relação à versão inicial.**
---
✅ Etapa 5 – Análise de vulnerabilidades com Trivy

A imagem Chainguard foi analisada utilizando o Trivy, ferramenta de segurança utilizada para identificar vulnerabilidades conhecidas em imagens de containers e dependências da aplicação.

A análise inicial foi realizada na imagem:

giropops-chainguard:1.0

O scan identificou uma vulnerabilidade no Flask 3.0.3:

CVE-2026-27205
Severity: LOW
Fixed Version: 3.1.3

A dependência foi atualizada no requirements.txt:

Flask==3.1.3

Uma nova imagem foi construída:

giropops-chainguard:1.1

Após a reconstrução, um novo scan foi executado:

trivy image --scanners vuln giropops-chainguard:1.1

Resultado
Severidade	Antes 1.0	  Depois 1.1
CRITICAL	        0    	  0
HIGH	            2	      2 
MEDIUM	          1   	  1
LOW	              1	      0

A vulnerabilidade do Flask foi eliminada após a atualização de 3.0.3 → 3.1.3.

Durante a análise, o Trivy também reportou msgpack e setuptools. Entretanto, esses pacotes não estavam presentes no ambiente Python da imagem, conforme validação realizada através do pip list e importlib.

O próprio Trivy apresentou o seguinte alerta durante a análise:

Third-party SBOM may lead to inaccurate vulnerability detection

Por esse motivo, os findings foram investigados antes de qualquer alteração adicional nas dependências.

🔎 Geração de SBOM

Também foi gerado um SBOM (Software Bill of Materials) utilizando o Trivy:

trivy image \
  --format cyclonedx \
  --output sbom.json \
  giropops-chainguard:1.1

O arquivo sbom.json foi gerado com sucesso e utilizado como parte da validação dos componentes presentes na imagem.

Benefícios obtidos
Introdução de análise automatizada de vulnerabilidades
Identificação e correção de vulnerabilidade real na aplicação
Validação da imagem após a correção
Geração de SBOM
Prática de investigação de falsos positivos
Maior visibilidade sobre dependências da aplicação
Integração de práticas de segurança ao ciclo de build

---

## 🛣️ Roadmap

- [x] Containerização da aplicação
- [x] Integração com Redis
- [x] Docker Multi-stage Build
- [x] Migração para imagem Chainguard
- [x] Análise de vulnerabilidades com Trivy
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
