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
python 3 -m venv venv

venv/bin/pip install -r requirements.txt

venv/bin/ansible-galaxy install -fr ansible-galaxy.yml

venv/bin/ansible-playbook -i hosts.yml --private-key ~/.ssh/id_rsa setup.yml -e email_address=flynshue@gmail.com
```