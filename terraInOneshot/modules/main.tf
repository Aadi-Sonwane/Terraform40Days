module "MymM1Module" {
  source = "./m1"
}

module "MyM2Module" {
  source = "./m2"

  instance_type = "t2.medium"
}