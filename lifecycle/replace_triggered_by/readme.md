replace_triggered_by (list of resource or attribute references) -

Added in Terraform 1.2. Replaces the resource when any of the referenced items change. 
Supply a list of expressions referencing managed resources, instances, or instance attributes. 
When used in a resource that uses count or for_each, you can use count.index or each.key in
the expression to reference specific instances of other resources that are configured with the 
same count or collection.

References trigger replacement in the following conditions:

If the reference is to a resource with multiple instances, 
a plan to update or replace any instance will trigger replacement.

If the reference is to a single resource instance,
a plan to update or replace that instance will trigger replacement.

If the reference is to a single attribute of a resource instance,
any change to the attribute value will trigger replacement.


----------------------------------------------------------
You probably wonder why you need this – and you’re right in doing so. 
Typically, Terraforms default dependency management works flawlessly.
Sometimes, however, you might want to replace your VM, 
because even though you can update the start up script without replacement,
you want a new instance for your own sanity. 

----------------------------------------------------------------------
What can we control?
As I have said above we can control - to some extent -
the lifecycle further than the three above stages for our resources. 
Terraform gives us the following options that we can use in the lifecycle meta-argument:

create_before_destroy — when an in-place update has to occur Terraform will create the new instance prior to destroying the old

prevent_destroy — do not allow the destroy flow to actually destruct the resource

ignore_changes — ignore any changes on specified fields or an entire object

replace_triggered_by
precondition — check some thing before performing the action on the resource
postcondition — validate some thing after performing an action on the resource

--------------------------------------------------------
