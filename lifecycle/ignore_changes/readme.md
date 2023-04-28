ignore_changes (list of attribute names) - 

By default, Terraform detects any difference in the current settings of 
a real infrastructure object and plans to update the remote object to match configuration.

The ignore_changes feature is intended to be used when a resource is created with references 
to data that may change in the future, but should not affect said resource after its creation. 
In some rare cases, settings of a remote object are modified by processes outside of Terraform,
which Terraform would then attempt to "fix" on the next run. In order to make Terraform share management
responsibilities of a single object with a separate process, the ignore_changes meta-argument specifies 
resource attributes that Terraform should ignore when planning updates to the associated remote object.


resource "aws_instance" "example" {
  # ...

  lifecycle {
    ignore_changes = [
      # Ignore changes to tags, e.g. because a management agent
      # updates these based on some ruleset managed elsewhere.
      tags,
    ]
  }
}


Instead of a list, the special keyword all may be used to instruct Terraform to ignore all attributes,
which means that Terraform can create and destroy the remote object but will never propose updates to it.
