# enables userpass
resource "vault_auth_backend" "userpass" {

  type = "userpass"     # type of auth method
  path = var.mount-path # location to mount the auth method

  # modify some configurations of userpass
  tune {

    max_lease_ttl = var.ttl # max time-to-live

  }

}

# create user and password
resource "vault_generic_endpoint" "user" {

  # logical path at which to write data
  path = "auth/${var.mount-path}/users/${var.user}"

  # login details
  data_json = <<EOT
  {
    "policies": ["mypolicy"],
    "password": "changeme"
  }
  EOT

  depends_on = [vault_auth_backend.userpass] # explicit dependency
}

# Error authenticating: Error making API request.

# URL: PUT http://127.0.0.1:8200/v1/auth/userpass/login/intern
# Code: 400. Errors:

# * missing client token


# resource "vault_generic_endpoint" "login" {

#   path = "auth/${var.mount-path}/login/${var.user}"

#   data_json = <<EOT
#   {
#     "password": "changeme"
#   }
#   EOT

#   depends_on = [vault_generic_endpoint.user] # explicit dependency

# }