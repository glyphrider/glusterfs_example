module "cloudinit" {
  source = "../cloudinit"
  template_file = "${path.cwd}/cloudinit.yml"
}

resource "libvirt_volume" "storage" {
  name = "${var.instance_name}_storage"
  size = 2*1024*1024*1024
  format = "qcow2"
}
  
module "host" {
  source = "../host_with_storage"
  instance_name = var.instance_name
  memory = 16384
  vcpu = 8
  disk = 25*1024*1024*1024
  cloudinit_id = module.cloudinit.id
  base_volume_name = "CentOS-8-GenericCloud-8.3.2011-20201204.2.x86_64.qcow2"
  storage_volume_id = libvirt_volume.storage.id
  private_network_id = var.private_network_id
}
