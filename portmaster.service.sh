#!/usr/bin/bash
[Unit]
Description=Portmaster Privacy App

[Service]
Type=simple
ExecStart=/opt/safing/portmaster/portmaster-start core --data=/opt/safing/portmaster/
ExecStopPost=-/sbin/iptables -F C17
ExecStopPost=-/sbin/iptables -t mangle -F C170
ExecStopPost=-/sbin/iptables -t mangle -F C171
ExecStopPost=-/sbin/ip6tables -F C17
ExecStopPost=-/sbin/ip6tables -t mangle -F C170
ExecStopPost=-/sbin/ip6tables -t mangle -F C171

[Install]
WantedBy=multi-user.target