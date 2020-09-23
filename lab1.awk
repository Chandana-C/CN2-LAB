BEGIN { count=0;
}{
    if ($1=="r")
    count++
}
END{
    printf("Number of packets dropped is = %d\n",count);
}