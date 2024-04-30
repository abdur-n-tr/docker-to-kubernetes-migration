terraform {
  required_providers {
    contabo = {
      source = "contabo/contabo"
      version = ">= 0.1.26"
    }
  }
}

# Configure your Contabo API credentials in provider stanza
provider "contabo" {
  oauth2_client_id     = "<oauth2_client_id>"
  oauth2_client_secret = "<oauth2_client_secret>"
  oauth2_user          = "<oauth2_client_secret>"
  oauth2_pass          = "<oauth2_client_secret>"
}

# Create a new secret
resource "contabo_secret" "root_password" {
  name        = "my_secret"
    type        = "password"
    value         = "<your-password>"
}

# Create a default contabo VPS instance
resource "contabo_instance" "default_instance" {
  root_password = contabo_secret.root_password.id
}


# Output our newly created instances
output "default_instance_output" {
  description = "Our first default instance"
  value       = contabo_instance.default_instance
}
