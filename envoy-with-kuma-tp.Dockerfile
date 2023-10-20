FROM kumahq/kumactl:2.4.3 as kuma

FROM envoyproxy/envoy-dev:006bbc3614724ead239fcc3a2438b4dd6b9173e6 as envoy

FROM ubuntu:jammy@sha256:9b8dec3bf938bc80fbe758d856e96fdfab5f56c39d44b0cff351e847bb1b01ea

COPY --from=envoy /usr/local/bin/envoy /usr/local/bin/envoy
COPY --from=kuma /usr/bin/kumactl /usr/bin/kumactl
COPY scripts/init.sh /init.sh

RUN chmod +x /init.sh

RUN apt-get update && \
    apt-get install --no-install-recommends -y iptables iproute2 curl

CMD ["/init.sh"]
