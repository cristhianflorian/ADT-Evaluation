resource "google_storage_bucket" "bucket" {
  name     = "${var.project_id}-function-hello-bucket"
  location = "US"
}

resource "google_cloudfunctions_function" "hello_function" {
  name        = "hello-function"
  runtime     = "python39"
  entry_point = "hello_world"
  source_archive_bucket = google_storage_bucket.bucket.name
  source_archive_object = google_storage_bucket_object.archive.name
  trigger_http = true
  available_memory_mb = 128
  https_trigger_security_level = "SECURE_ALWAYS"
  ingress_settings = "ALLOW_INTERNAL_AND_GCLB"
  project     = var.project_id
  region      = var.region
  environment_variables = {
    LOG_LEVEL = "INFO"
  }
}

resource "google_storage_bucket_object" "archive" {
  name   = "hello-function-source.zip"
  bucket = google_storage_bucket.bucket.name
  source = "${path.module}/../../cloud_function/main.zip"
}