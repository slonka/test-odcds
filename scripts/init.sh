#!/usr/bin/env bash

kumactl install transparent-proxy --kuma-dp-uid 0

useradd curl

/usr/local/bin/envoy -c /etc/envoy/envoy.yaml
