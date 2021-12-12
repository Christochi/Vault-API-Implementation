output "kv-data" {

  value = {

    # prints the the full path of the secrets being stored
    "path"   = module.kv.kv-path 
    "policy" = module.kv.policy # prints the policy

  }

}

output "approle-data" {

  value = {

    "renewable" = module.approle.renewable
    "lease_duration" = module.approle.lease-duration
    "lease_started" = module.approle.lease-started
    "client_token" = module.approle.client-token

  }

}

output "userpass-data" {

  value = module.userpass.userpass-data
  sensitive = true
  
}