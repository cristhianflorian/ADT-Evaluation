variable "project_id" {
  description = "GCP Project ID"
  type        = string
}

variable "region" {
  description = "GCP Region"
  type        = string
}

variable "function_name" {
  type        = string
  description = "Nombre de la función Cloud Function a usar en el NEG"
}