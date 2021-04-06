resource "libvirt_network" "gluster_network" {
  name = "gluster_network"
  mode = "none"
  domain = "gluster.local"
  addresses = ["192.168.123.0/24"]
}

module "glusterfs1" {
  source = "./modules/glusterfs_host"
  instance_name = "glusterfs1"
  private_network_id = libvirt_network.gluster_network.id
}

module "glusterfs2" {
  source = "./modules/glusterfs_host"
  instance_name = "glusterfs2"
  private_network_id = libvirt_network.gluster_network.id
}

module "glusterfs3" {
  source = "./modules/glusterfs_host"
  instance_name = "glusterfs3"
  private_network_id = libvirt_network.gluster_network.id
}

module "glusterclient" {
  source = "./modules/gluster_client"
  instance_name = "glusterclient"
}
