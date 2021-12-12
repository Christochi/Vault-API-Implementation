# data source which can be used to construct a HCL representation of a
# vault policy document
data "vault_policy_document" "policy_documents" {

  rule {
    path         = "${var.mount-path}/data/mysecrets"
    capabilities = ["update", "create", "read", "delete", "list", "sudo"]
    description  = "grants most permissions, including sudo"
  }

  rule {
    path         = "${var.mount-path}/data/certs"
    capabilities = ["update", "create", "read"]
    description  = "create, overwrite and read access"
  }

}

# creates acl policy for kv
resource "vault_policy" "acl" {

  name = var.policy # policy name

  # policy construct
  policy = data.vault_policy_document.policy_documents.hcl

}

