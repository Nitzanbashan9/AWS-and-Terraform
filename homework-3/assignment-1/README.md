# ReadMe
In this README you'll find information about the homework solution:

---

## The ".gitignore" file

-Please read more about what is ".gitignore" file [here](https://www.freecodecamp.org/news/gitignore-what-is-it-and-how-to-add-to-repo/#:~:text=gitignore%20file%20is%20a%20text,can%20also%20create%20a%20global%20.&text=Each%20new%20line%20should%20list,you%20want%20Git%20to%20ignore.).

-With that file, we can avoid accidentally pushing the Terraform state files to the repository.

---

## The "variables.tf" file

The statements for all the variables in our project, with a description and default value

---

## The "user_data.tf" file

Expression of the User-data by ["Local Value"](https://www.terraform.io/docs/language/values/locals.html)

---

## The "Provider.tf" file

-In this file we declare which local AWS profile to use to create all these resources, in our case, the profile name is: "Ops-School-profile"

-By using the provider [Default Tags](https://www.hashicorp.com/blog/default-tags-in-the-terraform-aws-provider) feature, we are automatically adding the "Owner" tag to every AWS resource created in this project.

---

## The "vpc.tf" file

This file creates the VPC and all its resources, such as:

a. Four subnets:
1. Private subnet in AZ A
2. Private subnet in AZ B
3. Public subnet in AZ A
4. Public subnet in AZ B

b. IGW (Associated with our VPC, of course).

c. Two NATs with two EIPs (one for each public AZ subnet).

d. Three Route tables:
1. Public route-table - associated with our public subnets and routes the outbound traffic to our Internet gateway.
2. Private route table A - Associated with our private subnet in AZ A, and routes the outbound traffic to our NAT A.
3. Private route table B - Associated with our private subnet in AZ B, and route the outbound traffic to our NAT B

- The Route tables themselves are defined separately from their rules.
  We asked you to do the same for this task.

-Count is used to avoid repeating the same resource declaration twice

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

## The "lb.tf" file

The Application Load balancer and its sub-resouces

The "aws_lb_listener":

a. Set the port and protocol on which the load balancer listens.
b. Choose the default routing method. In our case "forward" to the "aws_lb_target_group".


- "aws_lb_target_group":

a.

- "aws_lb_target_group_attachment"

If you have created classic load balancers, yes, it is also supported in layer 7.
However, CLB is already deprecated.

On August 11, 2016, AWS introduced its new Application Load Balancer (ALB).

ALB provides more advanced technology and options (such as advanced monitoring). When it comes to HTTP load balancing, ALB is recommended over CLB.

Click [here](https://www.sumologic.com/insight/aws-elastic-load-balancers-classic-vs-application/) for a detailed comparison between the types.


