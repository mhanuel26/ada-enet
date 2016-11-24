# Ada Embedded Network Stack

[![Build Status](https://img.shields.io/jenkins/s/http/jenkins.vacs.fr/Ada-Enet.svg)](http://jenkins.vacs.fr/job/Ada-Enet/)
[![License](http://img.shields.io/badge/license-APACHE2-blue.svg)](LICENSE)

This library is a small network stack that implements ARP, IPv4, UDP, DNS and DHCP protocols
on top of an Ethernet driver.  It can be compiled for a STM32F746 board
to provide IPv4 network access to your project.  This library is used
by the EtherScope project to read network packets and analyze the traffic
(See https://github.com/stcarrez/etherscope).  The following protocols are supported:

* IPv4 ([RFC 791](https://tools.ietf.org/html/rfc791))
* ICMP ([RFC 792](https://tools.ietf.org/html/rfc792))
* UDP ([RFC 768](https://tools.ietf.org/html/rfc768))
* ARP ([RFC 826](https://tools.ietf.org/html/rfc826))
* DNS ([RFC 1035](https://tools.ietf.org/html/rfc1035))
* DHCPv4 ([RFC 2131](https://tools.ietf.org/html/rfc2131))

Before build the library you will need:

* Ada_Drivers_Library
  https://github.com/AdaCore/Ada_Drivers_Library.git

* The GNAT Ada compiler for ARM
  http://libre.adacore.com/

The Ada_Drivers_Library is imported as part of a Git submodule.  To checkout everything, you may use
the following commands:

```shell
  make checkout
```

You can build the library with:

```shell
  arm-eabi-gnatmake -Panet_stm32f746 -p
```

## Ping

The ping application implements a simple ping on several hosts and displays
the ping counters on the STM32F LCD display.  The application has a static
IP configuration with IP address **192.168.1.2** and gateway **192.168.1.240**.
The application will continuously ping the hosts (192.168.1.1, 192.168.1.129,
192.168.1.240, 192.168.1.254 and 8.8.8.8).  The application will also answer
to ping requests.  If the static configuration is not suitable for your
network, change the lines in ping.adb:

```ada
--  Static IP interface, default netmask and no gateway.
Receiver.Ifnet.Ip := (192, 168, 1, 2);
Receiver.Ifnet.Gateway := (192, 168, 1, 240);
```

To build the Ping application you may run:

```shell
  make
```

And to flash the ping image, you can use:

```shell
  make flash-ping
```

## Echo

The echo application shows a simple UDP server that echos the received packet (RFC 862).
It listens on UDP port 7, loops to wait for UDP packets, returns them and increment a
counter of received packets which is displayed on the STM32 LCD display.

To build the Echo application you may run:

```shell
  make
```

And to flash the echo image, you can use:

```shell
  make flash-echo
```

And to test the echo UDP server, you may use the **echoping** command on GNU/Linux.
For example:

```shell
  echoping -v -u 192.168.1.2
```

## DNS

The dns application shows a simple DNS client resolver that queries a DNS to resolve a list
of hosts. 

To build the dns application you may run:

```shell
  make
```

And to flash the dns image, you can use:

```shell
  make flash-dns
```

## Documentation

- https://github.com/stcarrez/ada-enet/wiki
- [DHCP Client](https://github.com/stcarrez/ada-enet/wiki/Net_DHCP)
- [Using the Ada Embedded Network STM32 Ethernet Driver](http://blog.vacs.fr/vacs/blogs/post.html?post=2016/09/29/Using-the-Ada-Embedded-Network-STM32-Ethernet-Driver)
