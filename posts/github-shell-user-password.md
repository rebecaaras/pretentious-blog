---
title: Github pede usuário e senha no meu terminal
date: 2026-05-05
tags: bugs, github, ssh
---

# Github pede usuário e senha no meu terminal padrão

Um problema muito irritante que estou procrastinando resolver há semanas é: não consigo fazer git push a partir do meu terminal normal, apenas a partir do terminal do vs code. Há algo errado na configuração que preciso descobrir.

Por exemplo, a partir do meu shell zsh:

```
➜  eer-api git:(main) ✗ git push
Username for 'https://github.com':
Password for 'https://github.com':
remote: No anonymous write access.
fatal: Authentication failed for 'https://github.com/rebecaaras/eer-api.git/'
```

Enquanto a partir do terminal do VS Code tudo funciona normalmente:

```
➜  eer-api git:(main) ✗ git push
Everything up-to-date
```

Claramente há uma diferença na configuração... Provavelmente algo na autenticação via ssh não está funcionando adequadamente. (A propósito, o que é ssh mesmo?)

Felizmente o Stack Overflow nunca desaponta: [Why is Github asking for username/password](https://stackoverflow.com/questions/10909221/why-is-github-asking-for-username-password-when-following-the-instructions-on-sc#:~:text=This%20is%20an%20answer%20for,2%20Comments)

shell dentro do vs code:

```
➜  eer-api git:(main) ✗ git remote -v
origin  https://github.com/rebecaaras/eer-api.git (fetch)
origin  https://github.com/rebecaaras/eer-api.git (push)
```

shell fora do vs code:

```
➜  eer-api git:(main) ✗ git remote -v
origin	https://github.com/rebecaaras/eer-api.git (fetch)
origin	https://github.com/rebecaaras/eer-api.git (push)
```

Explicação: A partir do meu shell o acesso/origem está via https, estranhamente no vscode também. Porém, se eu altero a origem no shell fora do vs code, no meu caso fiz:

```
➜  eer-api git:(main) ✗ git remote set-url origin git@github.com:rebecaaras/eer-api.git
```

E então, voilà!

```
➜  eer-api git:(main) ✗ git push
Everything up-to-date
```

Agora, o que será que tem de diferente no vscode, porquê lá funciona mesmo com a origem via https? Cenas para algum próximo capítulo, quando eu tiver tempo de mexer nisso. Fica aqui este texto para me lembrar depois.
