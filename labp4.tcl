set ns [new Simulator]

set nt [open labp4.tr w]
$ns trace-all $nt

set topo [new Topography]
$topo load_flatgrid 1000 1000

set nf [open lp4.nam w]
$ns namtrace-all-wireless $nf 1000 1000

$ns node-config -adhocRouting DSDV \
	-llType LL \
	-macType Mac/802_11 \
	-ifqType Queue/DropTail \
	-ifqLen 20 \
	-phyType Phy/WirelessPhy \
	-channelType Channel/WirelessChannel \
	-propType Propagation/TwoRayGround \
	-antType Antenna/OmniAntenna \
	-topoInstance $topo \
	-agentTrace ON \
	-routerTrace ON

create-god 6

set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]
set n5 [$ns node]

$n0 label "tcp0"
$n1 label "sink0"
$n2 label "bs1"
$n3 label "bs2"
$n4 label "Source/udp0"
$n5 label "Destination/null"

$n0 set X_ 300
$n0 set Y_ 500
$n0 set Z_ 0

$n1 set X_ 250
$n1 set Y_ 300
$n1 set Z_ 0

$n2 set X_ 150
$n2 set Y_ 450
$n2 set Z_ 0

$n3 set X_ 650
$n3 set Y_ 400
$n3 set Z_ 0

$n4 set X_ 300
$n4 set Y_ 550
$n4 set Z_ 0

$n5 set X_ 450
$n5 set Y_ 600
$n5 set Z_ 0

set tcp0 [new Agent/TCP]
$ns attach-agent $n0 $tcp0

set ftp0 [new Application/FTP]
$ftp0 attach-agent $tcp0

set sink1 [new Agent/TCPSink]
$ns attach-agent $n1 $sink1

set udp0 [new Agent/UDP]
$ns attach-agent $n4 $udp0

set null0 [new Agent/Null]
$ns attach-agent $n5 $null0

set cbr0 [new Application/Traffic/CBR]
$cbr0 attach-agent $udp0

$ns connect $tcp0 $sink1
$ns connect $udp0 $null0

$cbr0 set packetSize_ 500Mb
$cbr0 set interval_ 0.035

proc finish {} {
	global ns nt nf

	$ns flush-trace

	exec nam labp4.nam &
	close $nt
	close $nf

	exit 0
}

$ns at 0.5 "$ftp0 start"
$ns at 0.5 "$cbr0 start"

$ns at 0.3 "$n0 setdest 110 500 10"
$ns at 0.3 "$n4 setdest 150 550 15"
$ns at 0.3 "$n1 setdest 600 500 20"
$ns at 0.3 "$n5 setdest 550 550 25"
$ns at 0.3 "$n2 setdest 300 500 30"
$ns at 0.3 "$n3 setdest 450 500 30"

$ns at 10.0 "$n0 setdest 100 550 5"
$ns at 10.0 "$n4 setdest 140 600 5"
$ns at 10.0 "$n1 setdest 630 450 5"
$ns at 10.0 "$n5 setdest 580 500 5"

$ns at 70.0 "$n0 setdest 170 680 5"
$ns at 70.0 "$n4 setdest 210 730 5"
$ns at 70.0 "$n1 setdest 580 380 5"
$ns at 70.0 "$n5 setdest 530 430 5"

$ns at 120.0 "$n0 setdest 140 720 5"
$ns at 120.0 "$n4 setdest 180 770 5"
$ns at 135.0 "$n0 setdest 110 600 5"
$ns at 135.0 "$n4 setdest 150 650 5"
$ns at 140.0 "$n1 setdest 600 550 5"
$ns at 140.0 "$n5 setdest 550 600 5"

$ns at 155.0 "$n0 setdest 89 500 5"
$ns at 155.0 "$n4 setdest 130 550 5"
$ns at 190.0 "$n0 setdest 100 440 5"
$ns at 190.0 "$n4 setdest 140 490 5"
$ns at 210.0 "$n1 setdest 700 600 5"
$ns at 210.0 "$n5 setdest 650 650 5"
$ns at 240.0 "$n1 setdest 650 500 5"
$ns at 240.0 "$n5 setdest 600 550 5"

$ns at 400 "finish"

$ns run