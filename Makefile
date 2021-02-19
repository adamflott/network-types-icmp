all:
	chmod u+w src/Network/Types/ICMP*.hs
	go run bin/specgen.go < spec/icmp-parameters.xml
	go run bin/specgen.go -use-v6 < spec/icmpv6-parameters.xml
	chmod u-w src/Network/Types/ICMP*.hs
