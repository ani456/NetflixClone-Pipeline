module "instance" {
  source = "./modules/instance"

  instance_type = "m7i-flex.large"
  instance_name = "Netflixclone-instance"
  key_name      = "linux-key"

}
