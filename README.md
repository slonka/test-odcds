# Test ODCDS

A dummy ODCDS server for Envoy.

## Flow

![architecture](./images/test-odcds.png "Architecture")

1. A client sends an HTTP request to Envoy. Envoy doesn't know about the target cluster.
2. Envoy queries the ODCDS server for the cluster configuration using xDS.
3. The ODCDS server returns the cluster configuration.
4. Envoy sends an HTTP request to the cluster.
5. The cluster responds.
6. Envoy sends a response to the client.

Subsequent HTTP requests from the client don't trigger new xDS queries as long as the TTL of the
cluster resource doesn't expire and Envoy isn't restarted.

## Running

>NOTE: We need 4 shells for experimenting with the server.

Create ODCDS network:

```
docker network create odcds
```

Run the ODCDS server in shell #1:

```
docker run --network odcds -ti -v $(pwd):/app/ golang bash
go run .
```

get network address

```
docker network inspect odcds
172.21.0.2
```

Run the dummy cluster in shell #2:

```
docker run --network odcds -ti -v $(pwd):/app/ golang bash
go run ./dummycluster
```

```
docker network inspect odcds
172.21.0.3
```

Run Envoy in shell #3:

```
docker run --rm -t -v $(pwd)/examples/envoy.yaml:/etc/envoy/envoy.yaml -p 8080:8080 -e ENVOY_UID=$(id -u) envoyproxy/envoy-dev:006bbc3614724ead239fcc3a2438b4dd6b9173e6
```

Send a request through Envoy in shell #4:

```
curl -H "Cluster-Name: foo" localhost:8080
```
