#Here I am creating for all user because I wanted to test cloud function allowing: Ingress > all just for testing.
#The correct way is should be changing in member to:  member = "serviceAccount:${var.project_number}@appspot.gserviceaccount.com" (App Engine default service account or create a new one with less scope)
resource "google_cloud_run_service_iam_member" "invoker" {
  project = var.project_id
  location = var.region
  service = var.function_name

  role = "roles/run.invoker"
  member = "allUsers" # para acceso público, o "user:correo@ejemplo.com" para acceso restringido
}

#Activanting observability. Is commented because in my projecto is already activated
#resource "google_project_service" "monitoring" {
#  service = "monitoring.googleapis.com"
#  project = var.project_id
#}

#resource "google_project_service" "logging" {
#  service = "logging.googleapis.com"
#  project = var.project_id
#}

resource "google_monitoring_dashboard" "hello_function_dashboard" {
  dashboard_json = jsonencode({
    displayName = "Hello Cloud Function Dashboard"
    gridLayout = {
      columns = 2
      widgets = [
        {
          title = "Execution Count"
          xyChart = {
            dataSets = [
              {
                timeSeriesQuery = {
                  timeSeriesFilter = {
                    filter = "metric.type=\"cloudfunctions.googleapis.com/function/execution_count\" resource.type=\"cloud_function\" resource.label.\"function_name\"=\"hello-function\""
                    aggregation = {
                      perSeriesAligner = "ALIGN_RATE"
                      alignmentPeriod = "60s"
                    }
                  }
                }
              }
            ]
            timeshiftDuration = "0s"
          }
        }
      ]
    }
  })
}

