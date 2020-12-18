BEGIN{
tcpPktsSent=0;
tcpPktsRcvd=0;
tcpPktsAtRTR=0;

udpPktsSent=0;
udpPktsRcvd=0;
udpPktsAtRTR=0;

}
{
if(($1=="s")&&($4=="RTR")&&($7=="tcp")) tcpPktsAtRTR++;
if(($1=="s")&&($4=="AGT")&&($7=="tcp")) tcpPktsSent++;
if(($1=="r")&&($4=="AGT")&&($7=="tcp")) tcpPktsRcvd++;

if(($1=="s")&&($4=="RTR")&&($7=="cbr")) udpPktsAtRTR++;
if(($1=="s")&&($4=="AGT")&&($7=="cbr")) udpPktsSent++;
if(($1=="r")&&($4=="AGT")&&($7=="cbr")) udpPktsRcvd++;
}
END{
print "Number of tcp Packets Sent :" tcpPktsSent
print "Number of tcp Packets Received :" tcpPktsRcvd
print "tcp Packet Delivery Ratio :" tcpPktsRcvd/tcpPktsSent*100
print "tcp Routing Load :" tcpPktsAtRTR/tcpPktsRcvd
print "\n"
print "Number of udp Packets Sent :" udpPktsSent
print "Number of udp Packets Received :" udpPktsRcvd
print "udp Packet Delivery Ratio :" udpPktsRcvd/udpPktsSent*100
print "udp Routing Load :" udpPktsAtRTR/udpPktsRcvd
}