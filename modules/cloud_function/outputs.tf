output "url" {
  description = "URL de la función Cloud Function"
  value = google_cloudfunctions_function.hello_function.https_trigger_url
}

output "name" {
  description = "URL de la función Cloud Function"
  value = google_cloudfunctions_function.hello_function.name
}