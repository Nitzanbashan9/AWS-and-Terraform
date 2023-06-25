# ReadMe
In this README you'll find information about the homework solution:


# The Module -

---

## The "vpc-module" directory

This directory contains a Terraform module that creates a VPC with the following resources:

1. Four `Subnets` - Two private (One in availability zone A and one on B) & Two public (One in availability zone A and one on B).

2. Two `Network Address Translation` (NAT) - Each resides on a private subnet (A & B).

3. Two Elastic IPS (EIP) - Each one is associated with one NAT.

4. Single `Internet gateway` associated with the `VPC` (unlike NAT, Internet gateway can't be touched to subnet and AZ, we have one for all the VPC. 

This is why we create two public RTBs (one per AZ private subnet) but only one private RTB.

5. Three `Route tables` (RTB)- Two "private" RTBs (Private-A & Private-B), each of them associated with one private subnet; and one "public" RTB, that is associated with the public subnets.

6. The private RTBs are associated with a rule that routes outgoing traffic to the relevant NATs (A & B) 

7. The public RTB is associated with a rule to route outbound traffic to the IGW

---

## The "vpc-module/output.tf" file

Output values are like the return values of a Terraform module, and have several uses:

- A child module can use outputs to expose a subset of its resource attributes to a parent module.
- A root module can use outputs to print certain values in the CLI output after running terraform apply.

This file contains all the outputs we need for the project that will use this module (the application).

As an example - We export the VPC ID for use in resources tagging / our [aws_lb_target_group](./lb.tf)

---

## The "vpc-module/variables.tf" file

The statements for all the variables in the VPC module part with a description. Variables without default values will be required when calling the module.


---

# The setup (application) -

---

## The "variables.tf" file

The statements for all the variables in the setup part (Thee application part - like EC2, IAM roles, LB...), with a description and default value

## The "main.tf" file

The file includes a call to the VPC module with all required values 

---

## The "Provider.tf" file

-In this file we declare which local AWS profile to use to create all these resources, in our case, the profile name is: "Ops-School-profile"

-By using the provider [Default Tags](https://www.hashicorp.com/blog/default-tags-in-the-terraform-aws-provider) feature, we are automatically adding the "Owner" tag to every AWS resource created in this project.

---

## The "DB_instances.tf" file

The nginx Database instances and their segurity group definitions

-`Count` is used to avoid repeating the same resource declaration twice

- The SG itself is defined separately from its rules.
  We asked you to do the same for this task.

---

## The "nginx-instances.tf" file

The nginx instances and their segurity group definitions

-`Count` is used to avoid repeating the same resource declaration twice

-Using the `user-data` of the instances, we install Nginx and change the home page

-We decided to declare the `user data` using [local value](https://www.terraform.io/docs/language/values/locals.html).
But there are other ways to set the `user data`, such as by the [file](https://www.terraform.io/docs/language/functions/file.html) Terraform function. So If you did it differently - it's also great.

- The SG itself is defined separately from its rules.
  We asked you to do the same for this task.


---

## The "nginx_bucket.tf" file

Definition of an Nginx S3 bucket where we store our Nginx access logs. 

---

## The "IAM.tf" file

The file contains definitions for IAM resources.
Our scenario is setting up IAM EC2 profile to have an IAM role and IAM policy that allows access to the S3 bucket.


By associating the EC2 profile with a Web instance, the access set in the Policy will be granted.


> Alternative - In the current case, where we only need s3 access, we could set the bucket access policy from the S3 bucket itself.


---

## The "user_data.tf" file

Expression of the WEB istances user-data by ["Local Value"](https://www.terraform.io/docs/language/values/locals.html)

Our user-data contains the following:

- Install Nginx

- Install AWS CLI (to send logs to S3 bucket with the AWS CLI command)

- Change the Nginx home page to include the hostname

- Bonus mission for the brave: Change the Nginx settings so that the logs contain [the real IP address](https://serverfault.com/questions/331531/nginx-set-real-ip-from-aws-elb-load-balancer-address) of the accessing server (instead of the LB address)

- Restart the Nginx service after making the change to apply it

- Set up a cron job on the server that will execute once an hour (0 * * * *) and send Nginx access logs to S3

---

## The "remote_state.tf" file

The definition of our backend. That is - where to store the state file.


Each Terraform configuration can specify a backend, which defines where and how operations are performed, where state snapshots are stored, etc.

In our case, we use the "s3" plugin and store the state in the AWS bucket.

>To emphasize, this is not the same bucket of Nginx, but a bucket that is solely for storing Terraform state.
>The bucket was created outside of Terraform's current project.

---

## The "lb.tf" file

The Application Load balancer and its sub-resouces

The "aws_lb_listener":

a. Set the port and protocol on which the load balancer listens.

b. Choose the default routing method. In our case "forward" to the "aws_lb_target_group".


- "aws_lb_target_group":

a. Set the Port on which targets receive traffic

b. Health check LB settings

- "aws_lb_target_group_attachment"

a. Associate between the LB to the LB target group


> If you have created classic load balancers, yes, it is also supported in layer 7.
However, CLB is already deprecated.

On August 11, 2016, AWS introduced its new Application Load Balancer (ALB).

ALB provides more advanced technology and options (such as advanced monitoring). When it comes to HTTP load balancing, ALB is recommended over CLB.

Click [here](https://www.sumologic.com/insight/aws-elastic-load-balancers-classic-vs-application/) for a detailed comparison between the types.



