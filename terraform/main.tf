resource "azurerm_resource_group" "main" { name = "${var.prefix}-rg"; location = var.location }
resource "azurerm_virtual_network" "main" { name = "${var.prefix}-vnet"; address_space = ["10.20.0.0/16"]; location = azurerm_resource_group.main.location; resource_group_name = azurerm_resource_group.main.name }
resource "azurerm_subnet" "aks" { name = "aks-subnet"; resource_group_name = azurerm_resource_group.main.name; virtual_network_name = azurerm_virtual_network.main.name; address_prefixes = ["10.20.1.0/24"] }
resource "azurerm_container_registry" "main" { name = replace("${var.prefix}acr", "-", ""); resource_group_name = azurerm_resource_group.main.name; location = azurerm_resource_group.main.location; sku = "Basic"; admin_enabled = false }
resource "azurerm_kubernetes_cluster" "main" {
 name = "${var.prefix}-aks"; location = azurerm_resource_group.main.location; resource_group_name = azurerm_resource_group.main.name; dns_prefix = var.prefix
 default_node_pool { name = "system"; node_count = 2; vm_size = "Standard_D2s_v3"; vnet_subnet_id = azurerm_subnet.aks.id }
 identity { type = "SystemAssigned" }
 linux_profile { admin_username = "aksadmin"; ssh_key { key_data = var.ssh_public_key } }
 network_profile { network_plugin = "azure"; load_balancer_sku = "standard"; service_cidr = "10.21.0.0/16"; dns_service_ip = "10.21.0.10" }
}
resource "azurerm_role_assignment" "acr_pull" { scope = azurerm_container_registry.main.id; role_definition_name = "AcrPull"; principal_id = azurerm_kubernetes_cluster.main.kubelet_identity[0].object_id }
