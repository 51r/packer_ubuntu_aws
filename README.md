# Ubuntu + Nginx instance in AWS using Packer

This repo includes template for Packer, that creates ubuntu instance with preinstalled nginx in aws.

## How to use the template
This guide applies to Mac, for other OS it may vary. 
* You need to have packer  installed on you workstation
   *  for MacOS you can install it using [homebrew](https://brew.sh/)
   
    ```
    brew install packer
    ```
  
   *  for any other OS click [here](https://packer.io/downloads.html) 

* Clone this repo locally to a folder of your choice
```
git clone https://github.com/51r/packer_ubuntu_aws.git
```
* Make sure you are in the main directory of the repo:

```
cd packer_ubuntu_aws
```
* Make sure you have allowed Packer to access your IAM user credentials, set your AWS access key ID as an environment variable
```
export AWS_ACCESS_KEY_ID="<YOUR_AWS_ACCESS_KEY_ID>"
```
* Then set your secret key:
```
export AWS_SECRET_ACCESS_KEY="<YOUR_AWS_SECRET_ACCESS_KEY>"
```
* Then set your AWS region:
```
export AWS_DEFAULT_REGION="<YOUR_AWS_REGION>"
```
If you don't have access to IAM user credentials, you can authenticate AWS using different methods described [here](https://www.packer.io/plugins/builders/amazon#authentication)
* Initialize Packer:
```
packer init .
```
If you initialize Packer for the first time, you should get the following message:
```
Installed plugin github.com/hashicorp/amazon v0.0.2 in "/Users/youruser/.packer.d/plugins/github.com/hashicorp/amazon/packer-plugin-amazon_v0.0.2_x5.0_darwin_amd64"
```
It will download Amazon Plugin which is required for the following instance to be build. Keep in mind that if you initialise the packer again, it will not show you any input, as the plugins needed for the instance are already downloaded.
* Build your environment:
```
packer build template.hcl
```
The installation log will be printed to the screen.In the end you should get the following output: 
```
==> Builds finished. The artifacts of successful builds are:
--> learn-packer.amazon-ebs.ubuntu: AMIs were created:
<YOUR_AWS_REGION: ami-ID
```
* Visit the AWS AMI page to verify that Packer successfully built your AMI. **learn-packer-ubuntu-aws**

* Select your AMI and click the button on the top right "Launch instance from AMI".

* Now you have created ubuntu instance with running nginx on it. 

* You can ssh to the instance and check if the nginx is running by executing the following command:
```
service nginx status
```

After you are done with the tests, remove the instance and deregister the AMI from AWS and remove the snapshot. This step should be done only if you wish to terminate the instance
