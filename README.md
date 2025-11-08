PART 1 — Infrastructure Setup (Terraform + AWS)
 Purpose

Automate provisioning of AWS cloud resources.

 AWS Services Used

 EC2 Instance
 VPC + Subnet
 Security Group (Allow HTTP 80 + SSH 22)
 Key Pair for SSH access

 Folder Structure
project/
 ├── terraform/
 
 │    ├── variables.tf
 │    ├── main.tf
 │    ├── outputs.tf

Steps to Provision Infrastructure
Install Terraform
sudo yum install -y terraform
terraform -v

Configure AWS Credentials
aws configure

Initialize Terraform
cd terraform
terraform init

Check and Apply Plan
terraform plan
terraform apply -auto-approve

Output

Terraform prints public IP of EC2.
SSH into EC2:

ssh -i aws-key.pem ec2-user@<EC2_PUBLIC_IP>


PART 2 — Configuration Management (Ansible + AWS)
Purpose

Install Docker & enable auto-start on EC2 automatically.


Ansible Inventory File
[webserver]
<EC2_PUBLIC_IP> ansible_user=ec2-user ansible_ssh_private_key_file=../aws-key.pem

Run Playbook
cd ansible
ansible-playbook -i inventory playbook.yaml

 Expected Result:

Docker installed
Docker service enabled at boot
User added to docker group

Commends
sudo yam update -y

sudo yum install docker -y

sudo service docker start

sudo service docker status

sudo su

docker version

docker search nginx

docker pull nginx

docker images

docker ps

docker run -d -p 80:80 nginx

docker ps

docker logs nginx

docker ps


(now copy id)

docker logs ID nginx id copy paste 

docker network ls


docker stop id

docker ps

docker ps -a

docker rm id

docker ps

docker ps -a

docker rmi nginx

docker images





PART 3 — Docker Container Deployment
🔹 Purpose

Deploy a sample web app container on EC2
File Structure

 │    ├── Dockerfile
 │    ├── index.html

Manual Deployment Commands

SSH to EC2:

sudo usermod -aG docker ec2-user
sudo reboot


Re-login → build container:

cd app
sudo docker build -t mywebapp .
sudo docker run -d -p 80:80 mywebapp


Check running containers:

docker ps


Open browser:





whoami

pwd

mkdir myapp

cd myapp/


echo "Hello I am husnain" > index.html

ls

cat index.html

touch demo.html

ls

vi demo.html

press i
then

write any sentence 

press :wq enter 

touch Dockerfile

ls -1



vi Dockerfile 

press i insert mod

docker info


sudo service docker start

docker build -t myapp .



docker images
docker run -p 8080:80 myapp

docker run -d -p 8080:80 myapp

docker ps

  

PART 4 — CI/CD Pipeline (GitHub Actions)
 Purpose

Whenever code is pushed →
GitHub Actions triggers
Terraform deploys infrastructure
Ansible installs Docker
App auto-deploys

Pipeline Files

 ├── .github/workflows/
 │    
 │    ├── deploy.yml

GitHub Configuration Steps
Push repository to GitHub
git init
git add .
git commit -m "DevOps Project"
git branch -M main
git remote add origin <Your-Repo-URL>
git push -u origin main
