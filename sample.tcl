
set ns [new Simulator]
set f [open sample.tr w]
$ns trace-all $f
set nf [open sample.nam w]
$ns namtrace-all $nf
proc finish {} {
global ns f
$ns flush-trace
close $f
exit 0
}
set n0 [$ns node]
set n1 [$ns node]
$ns duplex-link $n0 $n1 1Mb 10ms DropTail
$ns at 5.0 "finish"
$ns run
