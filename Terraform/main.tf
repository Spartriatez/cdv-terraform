module "resource_group" {
  source = "./modules/resource_group"

  application = var.application
  environment = "all"
  owner       = var.owner
  location    = var.location
  prefix      = var.prefix
}

module "la_resource_group" {
  source = "./modules/resource_group"

  application = "monitoring"
  environment = "all"
  owner       = var.owner
  location    = var.location
  prefix      = var.prefix
}

module "networking" {
  source = "./modules/networking"

  application         = var.application
  environment         = var.environment
  owner               = var.owner
  location            = var.location
  prefix              = var.prefix
  resource_group_name = module.resource_group.resource_group_name
}

module "webserver" {
  source = "./modules/virtual_machine"

  count = 2

  application         = var.application
  environment         = var.environment
  owner               = var.owner
  location            = var.location
  prefix              = var.prefix
  instances           = count.index
  admin_password      = var.admin_password
  resource_group_name = module.resource_group.resource_group_name
  subnet_id           = module.networking.subnet_id
  sg_id               = module.networking.sg_id
  create_public_ip    = false
  create_as           = true
  availability_set_id = module.availability_set.availability_set_id

  depends_on = [
    module.availability_set
  ]
}

/* module "bastion" {
  source = "./modules/virtual_machine"

  count = 1

  application         = "bastion"
  environment         = var.environment
  owner               = var.owner
  location            = var.location
  prefix              = var.prefix
  instances           = count.index
  admin_password      = var.admin_password
  resource_group_name = module.resource_group.resource_group_name
  subnet_id           = module.networking.subnet_id
  sg_id               = module.networking.sg_id
  create_public_ip    = true
  create_as           = false
} */

module "webserver_load_balancer" {
  source = "./modules/load_balancer"

  prefix              = var.prefix
  application         = var.application
  environment         = var.environment
  resource_group_name = module.resource_group.resource_group_name
  owner               = var.owner
  location            = var.location
  vm_names = [
    module.webserver[0].vm_name,
    module.webserver[1].vm_name
  ]
  vm_nic = [
    module.webserver[0].vm_nic,
    module.webserver[1].vm_nic
  ]

  depends_on = [
    module.webserver
  ]
}

module "availability_set" {
  source = "./modules/availability_set"

  prefix              = var.prefix
  application         = var.application
  environment         = var.environment
  location            = var.location
  owner               = var.owner
  resource_group_name = module.resource_group.resource_group_name
}

module "postgres_server" {
  source = "./modules/postgres_db"

  resource_group_name = module.resource_group.resource_group_name
  location            = var.location

  environment = var.environment
  application = var.application
  owner       = var.owner
  prefix      = var.prefix
}

module "log_analytics" {
  source      = "./modules/monitoring/log_analytics"
  prefix      = var.prefix
  application = var.application
  owner       = var.owner

  resource_group_name = module.la_resource_group.resource_group_name
  location            = var.location

}
