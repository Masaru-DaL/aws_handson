# AWS handson

## 1. システム構成図

![](/images/handson-aws-system-configuration-diagram.drawio.png)

## 2. 環境構築

### 2-1. terraformによる環境構築

- 環境構築
`$ terraform plan` => `$ terraform apply -auto-approve`

- 環境削除
`$ terraform destroy`

### 2-2. Cloud9の設定

Cloud9のIAMロールはterraformでアタッチ出来ないので手動で行う

- IAMロール
`IAMRoleForCloud9`をアタッチ

### 2-3. Cloud9から各EC2にSSHするための設定

1. Cloud9 IDEを開く

2. 各EC2にアクセスするために実行するスクリプトをS3からダウンロードする。
以下のコマンドを叩く

```bash:
sudo aws s3 cp s3://handson-development-s3/cloud9/connection_environment.sh /home/ec2-user/environment/
sudo aws s3 cp s3://handson-development-s3/cloud9/connection_information.sh /home/ec2-user/environment/

sudo chmod 700 /home/ec2-user/environment/*.sh
sudo chown ec2-user:ec2-user /home/ec2-user/environment/*.sh
```

3. スクリプトを実行する

`$ /home/ec2-user/environment/./connection_environment.sh`

4. 各EC2にSSH接続する

```bash:
# Web Server
ssh -i "~/.ssh/id_rsa_for_ec2" ubuntu@10.255.240.56

# Proxy Server
ssh -i "~/.ssh/id_rsa_for_ec2" ubuntu@10.255.240.38

# DNS Server
ssh -i "~/.ssh/id_rsa_for_ec2" ubuntu@10.255.240.74
```

- 各EC2に接続するコマンドの確認

`$ /home/ec2-user/environment/./connection_information.sh`

### 2-4. Microsoft Remote Desktopの設定

1. Windows ClientのWindowsパスワードを取得
2. パブリックIPアドレスを取得
