# 🔐 Git + GitHub – 2 comptes SSH sous Windows 11

Configuration propre et durable pour utiliser **2 comptes GitHub** (perso / pro) avec :
- PowerShell
- Git Bash
- VS Code
- **Un seul mot de passe par session Windows**

---

## 🎯 Objectif

- 2 comptes GitHub
- 2 clés SSH distinctes
- 1 agent SSH Windows
- Aucun mot de passe redemandé

---

## 🧩 Exemple de comptes

| Type | Email | Host SSH |
|------|------|---------|
| Perso | perso@email.com | github.com-perso |
| Pro | pro@email.com | github.com-pro |

---

## 1️⃣ Activer l’agent SSH Windows (UNE FOIS)

### PowerShell **en administrateur**

```powershell
Set-Service -Name ssh-agent -StartupType Automatic
Start-Service ssh-agent
```

Vérification :

```powershell
Get-Service ssh-agent
```

---

## 2️⃣ Générer les clés SSH (UNE PAR COMPTE)

### Compte perso

```bash
ssh-keygen -t ed25519 -C "perso@email.com" -f ~/.ssh/id_ed25519_perso
```

### Compte pro

```bash
ssh-keygen -t ed25519 -C "pro@email.com" -f ~/.ssh/id_ed25519_pro
```

➡️ Mettre un mot de passe (mémorisé par l’agent)

---

## 3️⃣ Ajouter les clés à l’agent SSH Windows

### PowerShell

```powershell
ssh-add $env:USERPROFILE\.ssh\id_ed25519_perso
ssh-add $env:USERPROFILE\.ssh\id_ed25519_pro
```

Vérification :

```powershell
ssh-add -l
```

---

## 4️⃣ Ajouter les clés sur GitHub

```bash
cat ~/.ssh/id_ed25519_perso.pub
cat ~/.ssh/id_ed25519_pro.pub
```

GitHub → **Settings → SSH and GPG keys → New SSH key**

---

## 5️⃣ Configurer SSH pour 2 comptes

```bash
nano ~/.ssh/config
```

```ssh
# --- GitHub Perso ---
Host github.com-perso
    HostName github.com
    User git
    IdentityFile ~/.ssh/id_ed25519_perso
    IdentitiesOnly yes

# --- GitHub Pro ---
Host github.com-pro
    HostName github.com
    User git
    IdentityFile ~/.ssh/id_ed25519_pro
    IdentitiesOnly yes
```

---

## 6️⃣ Forcer Git Bash à utiliser l’agent Windows

```bash
nano ~/.bashrc
```

Ajouter à la fin :

```bash
# Utiliser l'agent SSH Windows
export SSH_AUTH_SOCK=/tmp/ssh-agent.sock
```

```bash
source ~/.bashrc
```

---

## 7️⃣ Tester l’authentification

```bash
ssh -T git@github.com-perso
ssh -T git@github.com-pro
```

Résultat attendu :

```text
Hi username! You've successfully authenticated
```

---

## 8️⃣ Cloner avec le bon compte

```bash
git clone git@github.com-perso:username/repo.git
git clone git@github.com-pro:org/repo.git
```

---

## 9️⃣ Configurer l’identité Git par dépôt

```bash
git config user.name "Nom Perso"
git config user.email "perso@email.com"
```

ou

```bash
git config user.name "Nom Pro"
git config user.email "pro@email.com"
```

---

## 🔎 Vérifications finales

```bash
ssh-add -l
ssh -T git@github.com-perso
ssh -T git@github.com-pro
git config --list
```

---

## ✅ Résumé

| Élément | OK |
|------|----|
| Agent SSH Windows | ✅ |
| 2 clés SSH | ✅ |
| 1 mot de passe | ✅ |
| PowerShell / Git Bash / VS Code | ✅ |
| 2 comptes GitHub | ✅ |

---

📌 *Snippet prêt à être copié dans un README.md ou une doc interne.*

