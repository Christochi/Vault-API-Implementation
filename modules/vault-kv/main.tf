# function enables kv v2 secrets engine
resource "vault_mount" "kvv2" {

  path        = var.mount-path # location to mount the kv secrets engine
  type        = "kv-v2"        # type of backend
  description = "kv-v2 mount path @ foobar"

}

# writes data to kv store
resource "vault_generic_secret" "kvv2" {

  # logical path at which to write data
  path = "${vault_mount.kvv2.path}/${var.path-postfix}"

  # secrets to store
  data_json = <<EOT
  {
    "password": "bar",
    "user": "foo"
  }
  EOT

}
