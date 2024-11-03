#1. Create a ssh key:

```
ssh-keygen -t ed25519 -C ”your_email@example.com”
```

#2. Add your new key to the ssh-agent:

```
ssh-add ~/.ssh/id_ed25519
```

#3. Copy your key:

```
cat ~/.ssh/id_ed25519.pub
```

#4. Go to Github.com and click on "Add SSH key"

[Add SSH key](github.com/settings/keys)
