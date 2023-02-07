# Notes

## Testing

### How to run targetted resources and modules in terraform with backend-config

- Init:

```terraform init -target=aws_cloudtrail.trail -target=module.trail_log_storage -backend-config="test.backend.tfvars"```


```terraform init -target=aws_cloudtrail.trail -target=module.trail_log_storage -backend-config="test.backend.tfvars"```

- Plan:

```terraform plan -target=aws_cloudtrail.trail -target=module.trail_log_storage -var-file="test.terraform.tfvars"```

- Apply:
  
```terraform apply -target=aws_cloudtrail.trail -target=module.trail_log_storage -var-file="test.terraform.tfvars"```

```terraform apply -target=aws_cloudtrail.trail -var-file="test.terraform.tfvars"```

- Destroy:
  
```terraform destroy -target=aws_cloudtrail.trail -target=module.trail_log_storage -var-file="test.terraform.tfvars"```

## Refs

- [backend-config](https://developer.hashicorp.com/terraform/language/settings/backends/configuration)
