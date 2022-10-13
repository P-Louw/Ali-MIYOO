# MIYOO-MINI notifier - Ali express

Check if stock for retro console has been filled.
If so receive e-mail.

Variables for smtp en recipient have to be set using env or in dockerfile.

### Required envs
```
mail = "smtpsender@mail.com"
server = "smtphost.mail.com"
port = 587(outlook) or 25 (default/gmail)
password = "smtpmailpassword"

recipient = "myemail@mail.com"
```

### Example
```
docker build \
--build-arg mail="smtpsender@mail.com" \
--build-arg server="smtphost.mail.com" \
--build-arg port=587 \
--build-arg password="smtpmailpassword" \
--build-arg recipient="myemail@mail.com" \
--no-cache .
```
