# 🚀 Zabbix Provisionado com Terraform + GitHub Actions (AWS Free Tier)

Este projeto automatiza a criação de uma infraestrutura na AWS utilizando **Terraform** e **GitHub Actions** para provisionar um servidor **Zabbix 7.0 LTS** completo, incluindo Apache, MariaDB e frontend web.

## 💡 Objetivo

📌 Criar um ambiente real de monitoramento (Zabbix) com foco em:
- Boas práticas DevOps (IaC + CI/CD)
- Infraestrutura reprodutível
- Uso de recursos gratuitos (AWS Free Tier)

---

## 🧱 Infraestrutura

- 🌩️ **AWS EC2** (Ubuntu 22.04)
- 🧠 **Zabbix Server + Agent 7.0 LTS**
- 💾 **MariaDB** (como backend do Zabbix)
- 🌐 **Apache2** (servidor web)

---

## ⚙️ Como funciona

1. Código Terraform define a infraestrutura (VM, chave SSH, etc)
2. Script bash instala e configura Zabbix automaticamente
3. GitHub Actions roda o deploy assim que há push na branch `main`
4. Acesse a interface do Zabbix pelo IP da instância!

---

## ▶️ Como usar

### 1. Clone o repositório

```bash
git clone https://github.com/seu-user/zabbix-terraform-aws.git
cd zabbix-terraform-aws
```

### 2. Configure seus secrets no GitHub

```bash
| Nome                    | Valor                                           |
| ----------------------- | ----------------------------------------------- |
| `AWS_ACCESS_KEY_ID`     | sua chave de acesso da AWS                      |
| `AWS_SECRET_ACCESS_KEY` | sua chave secreta da AWS                        |
| `ZABBIX_PUBLIC_KEY`     | conteúdo da sua chave SSH pública (id\_rsa.pub) |
```

### 3. Acesse os Workflows do repositório e rode o "Deploy Zabbix AWS"

O GitHub Actions vai iniciar o deploy automaticamente via pipeline.

### 4. Acesse o Zabbix

🌐 IP da instância: veja na saída do Terraform
📥 Login: Admin
🔐 Senha: zabbix
