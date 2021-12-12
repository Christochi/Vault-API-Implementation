module "kv" {

  source = "../modules/vault-kv"

}

module "userpass" {

  source = "../modules/vault-userpass"
  policy = module.kv.policy # explicit dependency on policy

}

module "approle" {

  source = "../modules/vault-approle"
  policy = module.kv.policy # explicit dependency on policy

}