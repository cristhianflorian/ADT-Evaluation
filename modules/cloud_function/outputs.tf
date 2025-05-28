output "url" {
  description = "URL de la función Cloud Function"
  value = google_cloudfunctions2_function.hello_function.service_config[0].uri
}

output "name" {
  description = "URL de la función Cloud Function"
  value = google_cloudfunctions2_function.hello_function.name
}