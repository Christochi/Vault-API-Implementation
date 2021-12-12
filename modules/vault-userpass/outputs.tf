output "userpass-data" {

  value = {

    "mount-data" = vault_auth_backend.userpass
    "user-data"  = vault_generic_endpoint.user
    
  }

}