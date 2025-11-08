PART 1 — Infrastructure Setup (Terraform + AWS)

Purpose:
Automate the provisioning of AWS cloud resources so you don’t have to manually create EC2 instances, VPCs, or security groups every time.

AWS Services Used:

EC2 Instance

VPC + Subnet

Security Group (Allow HTTP 80 + SSH 22)

Key Pair for SSH access

Folder Structure:

project/
 ├── terraform/
 │    ├── variables.tf       # Define reusable variables (instance type, region, key pair)
 │    ├── main.tf            # Define resources (VPC, subnet, EC2, security group)
 │    ├── outputs.tf         # Display useful info (EC2 public IP)


Steps to Provision Infrastructure:

Install Terraform

sudo yum install -y terraform
terraform -v   # Verify installation


Configure AWS Credentials

aws configure
# Enter AWS Access Key, Secret Key, region, and output format


Initialize Terraform

cd terraform
terraform init   # Initializes terraform, downloads required providers


Check and Apply Plan

terraform plan           # Shows what Terraform will create
terraform apply -auto-approve  # Creates resources automatically


Get EC2 Public IP

Terraform will output the EC2 public IP. Use it to SSH into your server:

ssh -i aws-key.pem ec2-user@<EC2_PUBLIC_IP>


Comment: Always keep your key file (aws-key.pem) safe and do not share it publicly.

PART 2 — Configuration Management (Ansible + AWS)

Purpose:
Automatically install Docker on EC2 and ensure it starts at boot.

Ansible Inventory File (inventory)


<EC2_PUBLIC_IP> ansible_user=ec2-user ansible_ssh_private_key_file=../aws-key.pem


Run Playbook:

cd ansible
ansible-playbook -i inventory playbook.yaml


Expected Result:

Docker installed

Docker service enabled at boot

ec2-user added to Docker group

Manual Commands for Reference:

sudo yum update -y
sudo yum install docker -y
sudo service docker start
sudo service docker status
sudo usermod -aG docker ec2-user
docker version
docker pull nginx
docker run -d -p 80:80 nginx
docker ps
docker logs <container_id>
docker stop <container_id>
docker rm <container_id>
docker rmi nginx


Comment: Manual commands are for learning/debugging; in real projects, Ansible automates all this.

PART 3 — Docker Container Deployment

Purpose:
Deploy a sample web app container on EC2.

Folder Structure:

project/
 ├── app/
 │    ├── Dockerfile
 │    ├── index.html


Steps to Deploy:

SSH to EC2 & Add User to Docker Group

sudo usermod -aG docker ec2-user
sudo reboot


Build & Run Docker Container

cd app
sudo docker build -t mywebapp .
sudo docker run -d -p 80:80 mywebapp
docker ps   # Verify container is running


Access App in Browser

http://<EC2_PUBLIC_IP>


Commands to Create Simple Web App:

mkdir myapp
cd myapp
echo "Hello I am khadija" > index.html
touch Dockerfile


Sample Dockerfile:

# Use Nginx image
FROM nginx:alpine
COPY index.html /usr/share/nginx/html/index.html

sudo docker build -t myapp .
sudo docker run -d -p 8080:80 myapp
docker ps


Comment: Each docker build creates an image; docker run starts a container from the image. Use docker ps to monitor running containers.

PART 4 — CI/CD Pipeline (GitHub Actions)

Purpose:
Automate full workflow: whenever code is pushed → GitHub Actions triggers → Terraform deploys infrastructure → Ansible installs Docker → App auto-deploys.

Pipeline Folder Structure:

project/
 ├── .github/workflows/
 │    ├── deploy.yml


GitHub Steps:

git init
git add .
git commit -m "DevOps Project"
git branch -M main
git remote add origin <Your-Repo-URL>
git push -u origin main


Comment: deploy.yml defines the CI/CD pipeline. Each push triggers automated deployment.
