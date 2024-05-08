# Tofu
[Install](https://opentofu.org/docs/intro/install/deb/)

```bash
tofu -chdir=./terraform plan
tofu -chdir=./terraform -auto-approve apply
```

# Install aws cli

Somehow the last version has a bug, so we need the previoud one:
```bash
> curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
> unzip awscliv2.zip
> sudo ./aws/install --update
```

# Configure

```bash
> aws configure

<AWS Access Key ID> - Profile --> Security Credentials
<AWS Secret Access Key> - Profile --> Security Credentials
<Default region name> - EKS --> cluster --> top right corner
<Default output format> - json

> aws eks update-kubeconfig --region eu-central-1 --name mycluster
Added new context ... to ~/.kube/config
```
