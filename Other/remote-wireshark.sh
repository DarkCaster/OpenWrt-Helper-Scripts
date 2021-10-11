#!/bin/bash

script_dir="$(cd "$(dirname "$0")" && pwd)"

showusage() {
  echo "Usage: remote-wireshark.sh <router ip> <network interface name> [tcpdump filter, not port 22 by default]"
}

ipaddr="$1"
[[ -z $ipaddr ]] && showusage && exit 1

ifname="$2"
[[ -z $ifname ]] && showusage && exit 1

filter="$3"
[[ -z $filter ]] && filter="not port 22"

[[ ! -f "$script_dir/ssh.key" ]] && echo "ssh.key is missing, generate it first by running gen-keys.sh" && exit 1

terminate() {
  local name="$1"
  local pidfile="$2"
  local pid=""
  if [[ ! -z $pidfile && -f $pidfile ]]; then
    pid=$(cat "$pidfile")
    [[ ! -z $pid ]] && echo "terminating $name" && kill "$pid"
    rm -f "$pidfile"
  fi
}

ssh_pid=""
wireshark_pid=""
fifo_path=""

teardown() {
  local ec="$?"
  echo "teardown"
  terminate "ssh" "$ssh_pid"
  terminate "wireshark" "$wireshark_pid"
  [[ ! -z "$fifo_path" ]] && echo "removing fifo" && rm "$fifo_path"
  [[ ! -z "$ec" ]] && exit $ec || exit 0
}

check_error() {
  local ec="$?"
  if [[ "$ec" != "0" ]]; then
    teardown $ec
  fi
}

echo "creating fifo"
fifo_path=$(mktemp -u)
check_error

mkfifo "$fifo_path"
check_error

trap "teardown" SIGTERM SIGHUP SIGINT

echo "starting ssh"
ssh_pid=$(mktemp)
(
  ssh root@"$ipaddr" -C -T -i "$script_dir/ssh.key" tcpdump -i "$ifname" -U -s0 -w - \""$filter"\" >"$fifo_path" &
  pid=$!
  echo "$pid" >> "$ssh_pid"
  wait $pid
  rm -f "$ssh_pid"
) &

echo "starting wireshark"
wireshark_pid=$(mktemp)
(
  wireshark -k -i "$fifo_path" &
  pid=$!
  echo "$pid" >> "$wireshark_pid"
  wait $pid
  rm -f "$wireshark_pid"
) &

while sleep 1; do
  [[ ! -f $wireshark_pid ]] && echo "wireshark terminated" && teardown
done
