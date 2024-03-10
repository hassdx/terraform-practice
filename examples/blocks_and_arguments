# Arguments and Blocks

There are two core constructs in HCL: arguments and blocks.

An argument assigns a value to a particular name. Values could be any of value types or expression.


A block is a container for other content, like nested blocks and arguments. A block has type and labels(zero, one or two labels in Terraform).


```
    resource "aws_instance" "foo" {                         # block with "resource_type" and "resource_label"

      ami           = "ami-005e54dee72cc1d00"               # argument
      instance_type = "t2.micro"                            # argument
    
      network_interface {                                   # nested block without "resource_type" or "resource_label"
        network_interface_id = aws_network_interface.foo.id # argument of nested block
        device_index         = 0                            # argument of nested block
      }

      tags = {                                              # map of arguments
          "Name"    = "node-${var.name}-${var.region}"      # nested argument with expression
          "Project" = var.project                           # nested argument
        }
    }
```
