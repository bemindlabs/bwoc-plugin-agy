#!/usr/bin/env bash
set -e
jq . plugin.json >/dev/null && echo "plugin.json OK"
