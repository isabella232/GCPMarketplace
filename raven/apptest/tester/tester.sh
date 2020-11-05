set -xeo pipefail
shopt -s nullglob

SERVICE=$(kubectl get service | awk '/web-service/ { print $1 }')

EXTERNAL_IP=$(kubectl get service "${SERVICE}" \
  --namespace "${NAMESPACE}" \
  -ojsonpath="{.spec.clusterIP}")

export EXTERNAL_IP

for test in /tests/*; do
  testrunner -logtostderr "--test_spec=${test}"
done