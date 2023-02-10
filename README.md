# Terraform Bootcamp 

## Day 0:

1. Create AWS Free Tier Account.
2. Install AWS CLI .
3. Generate security credentials for you account and  run ```aws config``` in cmd to connect AWS account to your local machine.
4. Run "%UserProfile%/.aws" to check your confirgured profile[Under Credentials File]
5. Open VCS account[Github,Bitbucket,Gitlab...]


### AWS Terraform Documentation:
- Doc Reference: https://registry.terraform.io/providers/hashicorp/aws/latest/docs
- Tutorial Reference: https://developer.hashicorp.com/terraform/tutorials/aws-get-started

## Day 1:

1. Install Terraform in your system - https://learn.hashicorp.com/tutorials/terraform/install-cli?in=terraform/certification-associate-tutorials
2. Get started with Terraform with AWS - https://learn.hashicorp.com/tutorials/terraform/infrastructure-as-code?in=terraform/certification-associate-tutorials
3. Learn about ```terraform init```, ```terraform plan```, ```terraform apply```, ```terraform destory``` commands and there use cases. -https://learn.hashicorp.com/tutorials/terraform/aws-build?in=terraform/certification-associate-tutorials
4. What is ```state file``` and ```lock.hcl``` is terraform? - https://learn.hashicorp.com/tutorials/terraform/provider-versioning?in=terraform/certification-associate-tutorials
5. Create Terraform Cloud account and connect it with your workspace - https://learn.hashicorp.com/tutorials/terraform/aws-remote?in=terraform/certification-associate-tutorials
6. Move ```state file``` to terraform cloud.

### Learnings:

* Lock and upgrade provider version is used when some specific provider version is required. We can define that version under terraform block with reqiured version. If someone runs terraform init then dependecies of that particular version will be downloaded. But we have a option to upgrade that version to latest by ```terraform init -upgrade```. 
* There are three basic steps to provision infra. ```Write -> Plan -> Apply```.
* Terraform Cloud is a service provided by terraform where we can securly store our state files and env variables as well as use it within team to provision resouces. 

## Day 2:

### Terraform commands:

1. ```terraform init``` : This command is used to get all required dependencies of all mentioned providers.
2. ```terraform plan``` : This command is used to get an overview of resouces which we'll be provisining with our TF code.
3. ```terraform apply``` : This command actually provisions resources on cloud. 
4. ```terraform destroy``` : This command destroys all provioned resouces which were created with that particular TF file.
5. ```terraform validate``` : This command is used to validate the resouces which were provisioned.
6. ```terraform fmt``` : This command is used to format the TF file, e.g if code is not indented properly. It's remove wide spaces if present and format the file and give formated file name in CLI.
7. ```terraform show``` : This command is used to list all  resources which were provisioned using that TF file.
8. ```terraform output``` : Just like resource we have another module in TF called output, which can be used to provide certain information to User over CLI. Like if we're provisioning any EC2 instacne and we need subnet-id, private-ip, public-ip.. any information regarding that instance we can write code under ```Output```block and use that set of information. We can get that information when we run ```terraform apply``` and ```terraform output```.
~~~terraform
  output "Public_IP" {
  value = aws_instance.EC2_TF.public_ip
  }
~~~

### Steps to provision EC2 using Terraform:

1. Create ```main.tf``` file and give provider details in TF file. For now we're using AWS as provider.
   
~~~terraform
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "us-east-1"
}
~~~

2. Get required details for type of resource we need to provision. For example we need ami-id, instance type for provising EC2/VM.

~~~terraform
resource "aws_instance" "EC2_TF" {
  ami           = "ami-0aa7d40eeae50c9a9"
  instance_type = "t2.micro"

  tags = {
    Name = "EC2_TF"
  }
}
~~~

3. After writing your TF file, we can proceed with planing and provisioning our resources.
    * First we need to download required dependecies of provider using```terraform init```
    * Now after ```terraform init``` we can run ```terraform plan``` to check our code and get an overview of resouces we're going to provision
    * After ```terraform plan``` if everything looks good we can run ```terraform apply``` to provision resource.

> **_NOTE:_**  Destroy all provisioned infras as you may get charges for these.

### Learnings:
We can specificy multiple providers using alias in provider block and the same value should be refered as provider in resource block

~~~terraform
provider "aws" {
  region = "us-east-2"
  alias = "east-2"
}

#  crate aws instance
resource "aws_instance" "app_server" {
  # ami           = "ami-08d70e59c07c61a3a"
  ami = "ami-05bfbece1ed5beb54"
  instance_type = "t2.micro"
  provider = aws.east-2
  tags = {
    Name = "my-first-ec2"
  }
}
~~~


## Day 3:
1. Log in to Terraform Cloud from the CLI - https://learn.hashicorp.com/tutorials/terraform/cloud-login?in=terraform/certification-associate-tutorials

2. Migrate State to Terraform Cloud - https://learn.hashicorp.com/tutorials/terraform/cloud-migrate?in=terraform/certification-associate-tutorials

3. Customize Terraform Configuration with Variables - https://learn.hashicorp.com/tutorials/terraform/variables?in=terraform/certification-associate-tutorials

4. Output Data from Terraform - https://learn.hashicorp.com/tutorials/terraform/outputs?in=terraform/certification-associate-tutorials

5. Query Data Sources - https://learn.hashicorp.com/tutorials/terraform/data-sources?in=terraform/certification-associate-tutorials

6. Create Resource Dependencies - https://learn.hashicorp.com/tutorials/terraform/dependencies?in=terraform/certification-associate-tutorials


### Learnings:
1. How to login to terraform cloud
2. Maintain a state in terraform cloud , if any variable is declared in tf file as follows:

~~~
variable "name_length" {
  description = "The number of words in the pet name"
  default     = "3"
}
~~~

if we create the same "name_length" in tf cloud variables and change the value. So after tf apply the new value will be allocated.

3. Maintain a variable.tf file to create variables and refer in main file

4. 

5. 


## Day 4:

### Learnings on call:
1. String interpolation like string concatination
2. Different types of objects - list,map,string,boolean
3. Local variables
4. Datasources - to fetch details of data from source provider like aws
5. resource type in details -namespaces, name 

### Assignment
1. Copy assignment 1 as assignment 2
2. add variable file, add the variable values and use them in the manifest. 
3. Add s3 bucket /storage manually using AWS CLI/Azure CLI/AWS Console/Azure Portal
4. Output name and id of the s3 bucket /storage account
5. Output EC2 instance /VM related information 



### Learnings on assigment:
1. Created a separte variable.tf file to maintain variables

~~~
variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-west-2"
}
~~~

2. Created a data source to get the details of s3 bucket

~~~
data "aws_s3_bucket" "selected" {
  bucket   = "terraform-bucket-name"
  provider = aws.west-2
}
~~~

3. Created a output file to print outputs
~~~
output "instance_ids" {
  description = "IDs of EC2 instances"
  value       = aws_instance.app_server.*.id
}
~~~

4. Maintain state file in aws s3 bucket /storage

~~~
backend "s3" {
  bucket = "terraform-bucket-name"
  key = "myapp/terraform.tfstate"
  region = "us-west-2"
}
~~~

