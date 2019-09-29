{
    "LaunchTemplateData": {
        "EbsOptimized": false,
        "BlockDeviceMappings": [
            {
                "DeviceName": "/dev/sda1",
                "Ebs": {
                    "Encrypted": false,
                    "DeleteOnTermination": true,
                    "SnapshotId": "snap-01d8a2f723be8f0c0",
                    "VolumeSize": 15,
                    "VolumeType": "standard"
                }
            }
        ],
        "NetworkInterfaces": [
            {
                "AssociatePublicIpAddress": false,
                "DeleteOnTermination": true,
                "Description": "Primary network interface",
                "DeviceIndex": 0,
                "Groups": [
                    "sg-083c31775b1fa65f0"
                ],
                "InterfaceType": "interface",
                "Ipv6Addresses": [],
                "PrivateIpAddresses": [
                    {
                        "Primary": true,
                        "PrivateIpAddress": ""
                    }
                ],
                "SubnetId": "subnet-214a766a"
            }
        ],
        "ImageId": "ami-06f2f779464715dc5",
        "InstanceType": "t2.micro",
        "KeyName": "EC2_Linux_CI_Server",
        "Monitoring": {
            "Enabled": false
        },
        "Placement": {
            "AvailabilityZone": "us-west-2a",
            "GroupName": "",
            "Tenancy": "default"
        },
        "DisableApiTermination": true,
        "InstanceInitiatedShutdownBehavior": "stop",
        "TagSpecifications": [
            {
                "ResourceType": "instance",
                "Tags": [
                    {
                        "Key": "Name",
                        "Value": "Jenkins"
                    }
                ]
            }
        ],
        "CreditSpecification": {
            "CpuCredits": "standard"
        },
        "CpuOptions": {
            "CoreCount": 1,
            "ThreadsPerCore": 1
        },
        "CapacityReservationSpecification": {
            "CapacityReservationPreference": "open"
        },
        "HibernationOptions": {
            "Configured": false
        }
    }
}
