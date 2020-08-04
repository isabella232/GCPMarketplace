set -xeo pipefail
shopt -s nullglob

SERVICE="raven"

EXTERNAL_IP=$(kubectl get service "${SERVICE}" \
  --namespace "${NAMESPACE}" \
  -ojsonpath="{.spec.clusterIP}")

export EXTERNAL_IP

for test in /tests/*; do
  testrunner -logtostderr "--test_spec=${test}"
done