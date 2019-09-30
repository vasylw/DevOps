
{
    "LaunchTemplateData": {
        "EbsOptimized": false,
        "BlockDeviceMappings": [
            {
                "DeviceName": "/dev/sda1",
                "Ebs": {
                    "Encrypted": false,
                    "DeleteOnTermination": true,
                    "SnapshotId": "",
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
        "ImageId": var.amis[var.region],
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
                        "Value": "Database"
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
