.PHONY: install upgrade update chart help
default: upgrade
install: upgrade


help:
	@echo ""
	@echo "Available targets:"
	@echo "  upgrade -- Upgrade (or install) Apache CouchDB.  (default target)"
	@echo "  install -- Alias for \`upgrade\`."
	@echo "  chart  --  Update helm chart dependencies (only)."
	@echo "  help  --   This message."
	@echo ""

chart:
	@echo "Updating helmchart dependencies"
	@helm dep update ./couchdb

upgrade:
	@echo "Upgrading couchdb"
	helm upgrade --install couchdb --namespace couchdb --create-namespace ./couchdb
