# kot-labs-ops
Repo for managing kot-labs stuff in DO

# Terraform for creating DO droplet to host apps
Configure TF Cloud
```
cd terraform

export DIGITALOCEAN_TOKEN=$(lpass show --password blah)

export TF_CLI_CONFIG_FILE="$HOME/.terraformrc.home"

terraform init
```

## Dev env
Swap to dev terraform workspace
```
terraform workspace select plate-stack-dev
```

Running terraform
```
terraform plan \
-var-file dev.tfvars

terraform apply \
-var-file dev.tfvars
```

## Prod env
Swap to prod terraform workspace
```
terraform workspace select plate-stack-prod
```

Running terraform
```
terraform plan

terraform apply
```


## Bootstrap DO droplet
Use DO console to log into server and install ssh pubkey to root user authorized keys

```
vim ~/.ssh/authorized_keys
```

# Running ansible-playbook for initial setup of the server
```
python3 -m venv venv

venv/bin/pip install -r requirements.txt

venv/bin/ansible-galaxy install -fr ansible-galaxy.yml

# staging certs
venv/bin/ansible-playbook -i hosts.yml \
-e email_address=flynshue@gmail.com \
setup.yml

# prod certs
venv/bin/ansible-playbook -i hosts.yml
-e email_address=flynshue@gmail.com -e cert_type=prod
```

# Running ansible-playbook to update cod-maps or plate-stack
```
python3 -m venv venv

venv/bin/pip install -r requirements.txt

venv/bin/ansible-playbook -i hosts.yml update.yml
```

# Running ansible-playbook to update snappass
```bash
python3 -m venv venv

venv/bin/pip install -r requirements.txt

venv/bin/ansible-playbook -i hosts.yml update.yml -t snappass
```

# Deleting staging cert
```
certbot delete --cert-name test-plate-stack.kot-labs.com
```