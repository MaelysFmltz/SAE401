#!/bin/sh

MULTICAST_PORT=${MULTICAST_PORT:-5000}
TTL=${TTL:-64}
LOCALADDR=${LOCALADDR:-192.168.10.20}

ffmpeg -re -stream_loop -1 \
  #-fflags +genpts \
  -i /media/death.mp4 \
  #-c copy \
  -c:v copy -c:a copy -f mpegts \
  #-flush_packets 1 \
  #-muxdelay 0 \
  #-muxpreload 0 \
  #-f mpegts \
  "udp://239.1.1.1:${MULTICAST_PORT}?pkt_size=1316&ttl=${TTL}&localaddr=${LOCALADDR}" &

ffmpeg -re -stream_loop -1 -i /media/rickroll.mp4 \
  -c:v copy -c:a copy -f mpegts \
  "udp://239.1.1.2:${MULTICAST_PORT}?pkt_size=1316&ttl=${TTL}&localaddr=${LOCALADDR}" &

wait
