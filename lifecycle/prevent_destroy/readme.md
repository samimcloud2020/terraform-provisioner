prevent_destroy (bool) - 

This meta-argument, when set to true, will cause Terraform to reject with an error any plan
that would destroy the infrastructure object associated with the resource, as long as
the argument remains present in the configuration.

This can be used as a measure of safety against the accidental replacement of objects 
that may be costly to reproduce, such as database instances. However,
it will make certain configuration changes impossible to apply, 
and will prevent the use of the terraform destroy command once 
such objects are created, and so this option should be used sparingly.

Since this argument must be present in configuration for the protection 
to apply, note that this setting does not prevent the remote object from being destroyed

if the resource block were removed from configuration entirely: 
in that case, the prevent_destroy setting is removed along with it, 
and so Terraform will allow the destroy operation to succeed.


To prevent destroy operations for specific resources,
you can add the prevent_destroy attribute to your resource definition. 
This lifecycle option prevents Terraform from accidentally removing critical resources.

C:\1>terraform destroy  -auto-approve
data.aws_ami.ubuntu: Reading...
data.aws_ami.ubuntu: Read complete after 1s [id=ami-0aa2b7722dc1b5612]
aws_instance.web1: Refreshing state... [id=i-0d80c06f036328af6]
╷
│ Error: Instance cannot be destroyed
│
│   on ec2.tf line 18:
│   18: resource "aws_instance" "web1" {
│
│ Resource aws_instance.web1 has lifecycle.prevent_destroy set, but the plan calls for this        
│ resource to be destroyed. To avoid this error and continue with the plan, either disable
│ lifecycle.prevent_destroy or reduce the scope of the plan using the -target flag.
╵
