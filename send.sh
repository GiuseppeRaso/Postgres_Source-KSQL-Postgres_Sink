#!/bin/sh

curl -i -X POST -H "Accept:application/json" -H "Content-Type:application/json" localhost:8083/connectors/ -d @pgsource.json
#curl -i -X POST -H "Accept:application/json" -H "Content-Type:application/json" localhost:8083/connectors/ -d @pgsink.json

# TO DELETE A CONNECTOR
# curl -X DELETE http://localhost:8083/connectors/{name-connector}