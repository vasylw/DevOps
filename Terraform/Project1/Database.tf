resource "aws_launch_template" "Database" {
  name = "Database"
    
    BlockDeviceMappings {
            DeviceName = "/dev/sda1"
             Ebs {
                    Encrypted = false
                    DeleteOnTermination = true
                    VolumeSize = 15
                }
    }
        
    NetworkInterfaces {
            AssociatePublicIpAddress = false
            DeleteOnTermination = true
            Description = "Primary network interface"
            Groups = "sg-083c31775b1fa65f0"
            InterfaceType = "interface"
             PrivateIpAddresses { Primary = true }
            SubnetId = "subnet-214a766a"
    }
    ImageId = var.amis[var.region]
    InstanceType = "t2.micro"
    KeyName = "EC2_Linux_CI_Server"
        Monitoring  { Enabled = false }
        Placement { AvailabilityZone = var.region }
    DisableApiTermination = true
    InstanceInitiatedShutdownBehavior = "stop"
    TagSpecifications {
        ResourceType = "instance"
            Tags {
                Key = "Name"
                Value = "Database"
                }
    }
        CreditSpecification { CpuCredits = "standard" }
        CpuOptions {
            CoreCount = 1
            ThreadsPerCore = 1
        }
        CapacityReservationSpecification { CapacityReservationPreference = "open" }
        HibernationOptions { Configured = false }
}