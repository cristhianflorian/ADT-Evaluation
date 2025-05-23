# ADT-Evaluation

Este repositorio contiene la solución al desafío de **ADT**, enfocada en la implementación de infraestructura como código utilizando **Terraform** en **Google Cloud Platform (GCP)**.  
Se abordan aspectos clave como la gestión de múltiples entornos, autenticación, despliegue de funciones en la nube y monitoreo.

---

## Estructura del Proyecto
```text
├── cloud_function/ # Código fuente de la Cloud Function
├── modules/ # Módulos reutilizables de Terraform
├── terraform.tfstate.d/ # Estados de Terraform por workspace
├── main.tf # Configuración principal de Terraform
├── variables.tf # Definición de variables
├── outputs.tf # Salidas de Terraform
├── providers.tf # Configuración de proveedores
├── locals.tf # Variables locales
├── terraform.tfvars # Valores de variables
└── README.md # Documentación del proyecto
`````

## Despliegue

### Inicializar Terraform:
terraform init

### Crear y seleccionar workspaces
terraform workspace new dev
terraform workspace new rr
terraform workspace select dev

### Aplicar la configuración
terraform apply

### Autenticación en GCP
Para autenticarte con GCP y permitir que Terraform gestione los recursos:
gcloud auth application-default login

Este comando configura las credenciales de aplicación predeterminadas, necesarias para que Terraform interactúe con GCP.

## Monitoreo y Logging
Se ha incorporado monitoreo y logging utilizando GCP Cloud Monitoring y Logging para rastrear la salud y el rendimiento de la aplicación.
Esto incluye la creación de dashboards personalizados y la integración con Cloud Functions.

## Pruebas
gcloud functions describe hello-function --region=us-central1 --format='value(httpsTrigger.url)'

Realizar una solicitud HTTP:
curl https://<URL_DE_LA_FUNCIÓN>

## Notas
Asegúrate de tener configurado el SDK de GCP y estar autenticado correctamente antes de ejecutar los comandos de Terraform.

Los workspaces de Terraform permiten gestionar múltiples entornos (dev, rr, etc.) de forma aislada.

Si la función requiere permisos, asegúrate de asignar roles/cloudfunctions.invoker al principal adecuado.