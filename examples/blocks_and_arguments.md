# Arguments and Blocks

There are two core constructs in HCL: arguments and blocks.

An argument assigns a value to a particular name. Values could be any of value types or expression.


A block is a container for other content, like nested blocks and arguments. A block has type and labels(zero, one or two labels in Terraform).


```
    resource "aws_instance" "foo" {                         # block with "resource_type=resource" and 2 "resource_labels"

      ami           = "ami-005e54dee72cc1d00"               # argument
      instance_type = "t2.micro"                            # argument
    
      network_interface {                                   # nested block with "resource_type=network_interface" without any "resource_labels"
        network_interface_id = aws_network_interface.foo.id # argument of nested block
        device_index         = 0                            # argument of nested block
      }

      tags = {                                              # map of arguments
          "Name"    = "node-${var.name}-${var.region}"      # nested argument with expression
          "Project" = var.project                           # nested argument
        }
    }
```

```
terraform {                                                 # block with "resource_type=terraform" but without "resource_labels"
  backend "remote" {                                        # nested block with "resource_type=backend" and 1 "resource_label"
    hostname = "terraform.example.com"                      # argument of nested block
  }

  required_version = ">= 1.6.2"                             # nested argument

  required_providers {                                      # nested block with "resource_type=required_providers" but without "resource_labels"
    aws = {                                                 # map of arguments
      source  = "hashicorp/aws"                             # nested argument
      version = "5.31.0"                                    # nested argument
    }
  }
}
```

