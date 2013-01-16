: ==== start ====
TESTNAME=basic-pluto-11
/testing/guestbin/swan-prep --testname $TESTNAME

# confirm that the network is alive
ping -n -c 4 -I 192.0.1.254 192.0.2.254
# make sure that clear text does not get through
iptables -A INPUT -i eth1 -s 192.0.2.0/24 -j LOGDROP
# confirm with a ping to east-in
ping -n -c 4 -I 192.0.1.254 192.0.2.254

ipsec setup start
/testing/pluto/bin/wait-until-pluto-started

ipsec auto --add westnet-eastnet-ipv4
ipsec whack --debug-control --debug-controlmore --debug-parsing --debug-crypt
echo "initdone"