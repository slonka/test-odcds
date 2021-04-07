# Test ODCDS

A dummy ODCDS server for Envoy.

## Running

>NOTE: We need 4 shells for experimenting with the server.

Run the ODCDS server in shell #1:

```
go run .
```

Run the dummy cluster in shell #2:

```
go run ./dummycluster
```

Run Envoy in shell #3:

```
# Configure the path to the Envoy binary.
export ENVOY_BIN=/tmp/envoy-bin/envoy

# Run Envoy.
$ENVOY_BIN --config-path examples/envoy.yaml
```

Send a request through Envoy in shell #4:

```
curl -H "Cluster-Name: foo" localhost:8080
```
