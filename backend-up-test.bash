#!/bin/bash

# -----------------------------------------------------------------------------
# JSatOrb project: backend test script.
# -----------------------------------------------------------------------------

# The curl command below can be used to check if the JSatOrb backend REST server is successfully 
# running.
# It can be used either in the backend Docker container or in the Docker host.
curl -H "content-type: application/json" -X GET http://localhost:8000/missiondata/Mission-Test-01