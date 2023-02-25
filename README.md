NAME: scratch
LAST DEPLOYED: Sat Feb 25 10:25:00 2023
NAMESPACE: default
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
Apache CouchDB is starting. Check the status of the Pods using:

  kubectl get pods --namespace default -l "app=couchdb,release=scratch"

Skip this step if autoSetup is enabled - Once all of the Pods are fully Ready, execute the following command to create
some required system databases:

  NAMESPACE=couchdb
  HELM_DEPLOYMENT_NAME=couchdb
  ADMIN_USERNAME="$(kubectl get secret couchdb-couchdb -o jsonpath="{.data.adminUsername}" | base64 --decode)"
  ADMIN_PASSWORD="$(kubectl get secret couchdb-couchdb -o jsonpath="{.data.adminPassword}" | base64 --decode)"
  echo "Namespace:  ${NAMESPACE}"
  echo "Deployment: ${HELM_DEPLOYMENT_NAME}"
  echo "Username:   ${ADMIN_USERNAME}"
  echo "Password:   ${ADMIN_PASSWORD}"
  #
  kubectl exec --namespace ${NAMESPACE} -it "${HELM_DEPLOYMENT_NAME}-couchdb-0" -c couchdb -- \
      curl -s \
	  http://127.0.0.1:5984/_cluster_setup \
	  -X POST \
	  -H "Content-Type: application/json" \
	  -d '{"action": "finish_cluster"}' \
	  -u "${ADMIN_USERNAME}:${ADMIN_PASSWORD}"

Then it's time to relax.

NOTE: You are using an auto-generated value for the Erlang Cookie
  - We recommend making this value persistent by setting it in: `erlangFlags.setcookie`
  - Changing this value can cause problems for the Couch DB installation (particularly upgrades / config changes)
  - You can get the current value with:
```
kubectl -n default get secret scratch-couchdb --template='{{index .data "erlangCookie" | base64decode}}'
```

Example output: sj6IQRJNNU3vYAOSt2lV

  (20 character string)



ajpippin.us Wildcard cert can be found at:  /Users/abp/.ssh/ajpippin.us-tls.yaml
