resource "google_storage_bucket" "bucket" {
  name     = "${var.project_id}-function-hello-bucket"
  location = "US"
}

resource "google_cloudfunctions2_function" "hello_function" {
  name     = "hello-function"
  location = var.region
  project  = var.project_id

  build_config {
    runtime     = "python39"
    entry_point = "hello_world"
    source {
      storage_source {
        bucket = google_storage_bucket.bucket.name
        object = google_storage_bucket_object.archive.name
      }
    }
  }

  service_config {
    available_memory = "256M"
    timeout_seconds     = 60
    ingress_settings = "ALLOW_INTERNAL_AND_GCLB"
    max_instance_count = 3
  }
}

resource "google_storage_bucket_object" "archive" {
  name   = "hello-function-source.zip"
  bucket = google_storage_bucket.bucket.name
  source = "${path.module}/../../cloud_function/main.zip"
}