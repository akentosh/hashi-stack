![](assets/logo.png)

# Overview
This contains HashiCorp code to do the following:
1. Packer template to build an Ubuntu 18.04 image consisting of 'HashiStack', which is Consul, Nomad and Vault
2. Terraform code to provision the HashiStack in 2-3 separate AWS regions with peering
3. Automated cluster formation of Consul and Nomad in each region
4. Automated cluster formation of Vault in each region
5. Automated WAN joining of Consul and Nomad
6. Automated replication configuration of Vault clusters in each region

## Assumptions
- Packer and Terraform are available on local machine
- Vault Enterprise linux binary available locally (Consul Enterprise and Nomad Enterpise are optional)
- User possesses AWS account and credentials

# Enterprise Demo Setup

## Step 1: Use Packer to build AMIs
This is most likely optional as Terraform will automatically pull the latest hashi-stack AMIs from our account.

0. change to the packer directory `packer/`
1. Download Consul, Nomad, and Vault binaries locally (Vault enterprise required, Consul and Nomad Enterprise )
2. Copy packer/vars.json.example to packer/vars.json
3. Configure variables local path to those binaries in packer/vars.json
4. Ensure AWS credentials are exposed as environment variables
5. Expose AWS environment variables to avoid AMI copy timeouts:
    ```
    $ export AWS_MAX_ATTEMPTS=60 && export AWS_POLL_DELAY_SECONDS=60
    ```
6. Enter Packer directory:
    ```
    $ cd packer
    ```
7. Download enterprise binaries and add variables to vars.json (copied from vars.json.example):
        ```
        $ packer build -var-file=vars.json -only=amazon-ebs-centos-7 packer.json   
        ```

## Step 2: Terraform Enterprise  
[TFE URL](https://app.terraform.io). This setup assumes you have a TFE SaaS account and a VCS connection setup. You could also push the code up via the enhanced remote backend, TFE-CLI, or API.

0. [Create a workspace](https://www.terraform.io/docs/enterprise/workspaces/creating.html) in TFE for musical-spork. I'm calling it the "Hashi-Stack" here for demo purposes. (Note the workspace settings from the below image)

![](assets/create_workspace.png)

1. [Configure variables
](https://www.terraform.io/docs/enterprise/workspaces/variables.html) for the workspace, [available variables](terraform/variables.tf).  Note: add the `CONFIRM_DESTROY = 1` environment variable as well so you can destroy the workspace.

![](assets/configure_variables.png)

2. (Optional, but highly recommended) Add some [Sentinel Policies](https://www.terraform.io/docs/enterprise/sentinel/index.html) to your TFE workspace. [Examples](https://www.terraform.io/docs/enterprise/sentinel/examples.html)

![](assets/sentinel_policy.png)

3. Queue a terraform plan. Show plan and policy check results. The demo is around 140 resources at the time of writing. Your policy checks will most likely differ :).

![](assets/plan.png)

4. Run Apply

## Step 3: Business Value Demos
[TODO LINK](). You will use the terraform output from this workspace for your demos.

## Step 4: Auto Shutdown, TFE Workspace Reaper
Finally, automate the automatic deltion of your demo environment via Adam's [TFE Workspace Reaper](https://github.com/AdamCavaliere/TFE_WorkspaceReaper/).

1. Fork the above repo
2. Create a workspace in TFE linked to said repo
3. Populate proper envionment variables (Use TFE Team or proper User API Token)

![](assets/workspace_reaper_vars.png)

4. For the TFE workspaces you want reaped, set "WORKSPACE_TTL" environment variable to an integer (in minutes) time to live.

## Terraform OSS usage (Use TFE if possible)

1. Configure Terraform variables:
    ```
    $ cp terraform.tfvars.example terraform.tfvars
    ```
2. Edit `terraform.tfvars`
3. Initialize Terraform:
    ```
    $ cd terraform
    $ terraform init
    ```
4.  Terraform plan execution with summary of changes:
    ```
    $ terraform plan
    ```
5. Terraform apply to create infrastructure:
    * With promt:
        ```
        $ terraform apply 
        ```
    * Without prompt:
        ```
        $ terraform apply -auto-approve
        ```
6. Tear down infrastructure using Terraform destroy:
    ```
    $ terraform destroy -force
    ```
