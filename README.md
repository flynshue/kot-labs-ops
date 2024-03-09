# kot-labs-ops
Repo for managing kot-labs stuff in DO

# Terraform for creating DO droplet to host apps
Configure TF Cloud
```
export TF_CLI_CONFIG_FILE="$HOME/.terraformrc.home"

terraform init
```

Running terraform
```
terraform plan -var do_token=$(lpass show --password blah)
```

# Running ansible-playbook for initial setup of the server
```
python3 -m venv venv

venv/bin/pip install -r requirements.txt

venv/bin/ansible-galaxy install -fr ansible-galaxy.yml

# staging certs
venv/bin/ansible-playbook -i hosts.yml --private-key ~/.ssh/id_rsa setup.yml -e email_address=flynshue@gmail.com

# prod certs
venv/bin/ansible-playbook -i hosts.yml --private-key ~/.ssh/id_rsa setup.yml -e email_address=flynshue@gmail.com -e cert_type=prod
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