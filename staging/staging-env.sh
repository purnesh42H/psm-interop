# GCP project
export PROJECT_ID="bct-gcestaging-guitar-grpc"
#[[ "$(gcloud config get project 2> /dev/null)" == "${PROJECT_ID}" ]] || exit 1
export PROJECT_NUMBER="921384807982"
export NETWORK="default"
export UHC_IPS="35.191.0.0/16,130.211.0.0/22"

# Default SAs
export GCE_SA="${PROJECT_NUMBER}-compute@developer.gserviceaccount.com"
# https://g3doc.corp.google.com/cloud/kubernetes/g3doc/dev/releasing/infrastructure.md
export GKE_SA="service-${PROJECT_NUMBER}@container-engine-robot-test.iam.gserviceaccount.com"

# Localities
export REGION_PRIMARY="europe-west1"
export ZONE_PRIMARY="$REGION_PRIMARY-cloudrackwo"
export REGION_SECONDARY="europe-west4"
export ZONE_SECONDARY="$REGION_SECONDARY-el1"

# Clusters
export CLUSTER_NAME_LB_PRIMARY="bct-psm-interop-lb-primary"
export CLUSTER_NAME_LB_SECONDARY="bct-psm-interop-lb-secondary"
export CLUSTER_NAME_URL_MAP="bct-psm-interop-url-map"
export CLUSTER_NAME_SECURITY="bct-psm-interop-security"

# IP Plan
# /15 for each cluster: /16 for pods + /16 for services
# Second octet: even for pods, odd for services
# List existing subnet secondary ranges:
# gcloud compute networks subnets describe default --region="${REGION_PRIMARY}"
export CLUSTER_LB_PRIMARY_PODS_CIDR="10.110.0.0/16"
export CLUSTER_LB_PRIMARY_SERVICES_CIDR="10.111.0.0/16"
export CLUSTER_LB_SECONDARY_PODS_CIDR="10.112.0.0/16"
export CLUSTER_LB_SECONDARY_SERVICES_CIDR="10.113.0.0/16"
export CLUSTER_URL_MAP_PODS_CIDR="10.114.0.0/16"
export CLUSTER_URL_MAP_SERVICES_CIDR="10.115.0.0/16"
export CLUSTER_SECURITY_PODS_CIDR="10.116.0.0/16"
export CLUSTER_SECURITY_SERVICES_CIDR="10.117.0.0/16"

# cluster versions:
# gcloud container get-server-config --zone "${ZONE_PRIMARY}"
# gcloud container get-server-config --zone "${ZONE_SECONDARY}"
# 2023-01-20: 1.24.8-gke.2000 REGULAR defaultVersion
# 2023-01-20: 1.23.14-gke.1800 STABLE defaultVersion
# 2023-03-17: 1.25.6-gke.1000 STABLE
# 2023-07-13: 1.25.8-gke.1000 STABLE defaultVersion
# 2024-06-10: 1.29.5-gke.1165000
export CLUSTER_VERSION_DEFAULT="1.29.5-gke.1165000"

# machine-types:
# gcloud compute machine-types list --zones="${ZONE_PRIMARY},${ZONE_SECONDARY}"
# NAME            ZONE                      CPUS  MEMORY_GB
# e2-highmem-4    europe-west1-cloudrackwo  4     32.00
# e2-highmem-4    europe-west4-el1          4     32.00
export CLUSTER_MACHINE_TYPE_DEFAULT="e2-highmem-4"
# disk types:
# DISK_TYPE must be one of: pd-standard, pd-ssd, pd-balanced (see gcloud container clusters create --help).
# gcloud compute disk-types list --zones="${ZONE_PRIMARY},${ZONE_SECONDARY}"
# NAME                  ZONE                      VALID_DISK_SIZES
# pd-ssd                europe-west1-cloudrackwo  10GB-65536GB
# pd-ssd                europe-west4-el1          10GB-65536GB
export CLUSTER_DISK_TYPE_DEFAULT="pd-ssd"
# other settings:
export CLUSTER_PRIMARY_NUM_NODES_DEFAULT=9
export CLUSTER_SECONDARY_NUM_NODES_DEFAULT=6
export CLUSTER_HEALTHCHECK_TAG="allow-health-checks"

# Workload identity: https://cloud.google.com/kubernetes-engine/docs/how-to/workload-identity
export WORKLOAD_POOL="${PROJECT_ID}.svc.id.goog"
# TODO(sergiitk): rename to psm-interop-tests for consistency
export WORKLOAD_SA_NAME="xds-k8s-interop-tests"
export WORKLOAD_SA_EMAIL="${WORKLOAD_SA_NAME}@${PROJECT_ID}.iam.gserviceaccount.com"

# PSM Security infra setup
# Private CA: https://cloud.google.com/certificate-authority-service/docs
# Locations: gcloud privateca locations list
# Root CA
export ROOT_CA_POOL_NAME="interop-psm-security-root-ca-pool-v3"
export ROOT_CA_NAME="interop-psm-security-root-ca-v3"
export ROOT_CA_ORGANIZATION="Joonix LLC"
# TODO(sergiitk): consider recreating in $REGION_PRIMARY (europe-west1) to be closer to the clusters
export ROOT_CA_POOL_LOCATION="us-west1"
export ROOT_CA_URI="//privateca.googleapis.com/projects/${PROJECT_ID}/locations/${ROOT_CA_POOL_LOCATION}/caPools/${ROOT_CA_POOL_NAME}"
# Subordinate CA
export SUBORDINATE_CA_POOL_NAME="interop-psm-security-sub-ca-pool-v3"
export SUBORDINATE_CA_POOL_LOCATION="${ROOT_CA_POOL_LOCATION}"
export SUBORDINATE_CA_NAME="interop-psm-security-sub-ca-v3"
export SUBORDINATE_CA_ORGANIZATION="SubJoonix LLC"
export SUBORDINATE_CA_URI="//privateca.googleapis.com/projects/${PROJECT_ID}/locations/${SUBORDINATE_CA_POOL_LOCATION}/caPools/${SUBORDINATE_CA_POOL_NAME}"
# The CA service that issues your certificates (see WorkloadCertificateConfig.yaml)
export ISSUING_CA_URI="${SUBORDINATE_CA_URI}"

# Security cluster extra settings
export KUBE_CONTEXT_SECURITY="gke_${PROJECT_ID}_${ZONE_PRIMARY}_${CLUSTER_NAME_SECURITY}"
export PRIVATE_API_KEY_DISPLAY_NAME="xDS interop tests private API access"
export PRIVATE_API_KEY_SECRET_NAME="xds-interop-tests-private-api-access-key"

# Staging
export DEV_SANDBOX="bct-staging-proxyless-jan3-test-container"
# Staging UHC IPs: http://google3/cloud/services_platform/ksp/translator/firewall.go;l=29;rcl=465115935
export UHC_IPS="${UHC_IPS},108.170.220.0/24,35.235.160.0/23,35.235.164.0/22,34.124.104.0/22"
# go/bct-test-user-migration-to-service-accounts
export BCT_SA="grpc-interop-bct-test-user-00@bct-gcestaging-guitar-grpc.iam.gserviceaccount.com"
