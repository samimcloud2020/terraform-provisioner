create_before_destroy (bool) -

By default, when Terraform must change a resource argument that 
cannot be updated in-place due to remote API limitations, Terraform will instead destroy the existing
object and then create a new replacement object with the new configured arguments.

The create_before_destroy meta-argument changes this behavior so that the new replacement 
object is created first, and the prior object is destroyed after the replacement is created.

This is an opt-in behavior because many remote object types have unique name requirements 
or other constraints that must be accommodated for both a new and an old object to exist concurrently.
Some resource types offer special options to append a random suffix onto each object name to avoid collisions, for example.
Terraform CLI cannot automatically activate such features, so you must understand the constraints 
for each resource type before using create_before_destroy with it.
