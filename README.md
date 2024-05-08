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

# kubectl

```bash
> kubectl apply -f kube/
> kube/helm.sh

> k get -n my-namespace ingress
NAME           CLASS   HOSTS                     ADDRESS                                                                     PORTS   AGE
cafe-ingress   nginx   cafe.xn--w8je.xn--tckwe   XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX-YYYYYYYY.eu-central-1.elb.amazonaws.com   80      27s

> curl --header 'Host: cafe.xn--w8je.xn--tckwe' http://XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX-YYYYYYYY.eu-central-1.elb.amazonaws.com/coffee
Server address: 10.0.2.51:8080
Server name: coffee-58b984b874-rkpzb
Date: 08/May/2024:09:00:41 +0000
URI: /coffee
Request ID: e6621a3a368cc42095f89f844fcac464

> curl --header 'Host: cafe.xn--w8je.xn--tckwe' http://XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX-YYYYYYYY.eu-central-1.elb.amazonaws.com/tea
Server address: 10.0.2.112:8080
Server name: tea-548dbbcd9b-kv67x
Date: 08/May/2024:09:03:45 +0000
URI: /tea
Request ID: baf225aa00830979f58525cff1a97fdf
```