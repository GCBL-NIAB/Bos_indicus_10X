#!/usr/bin/perl

my %data;

open(FILE1, "$ARGV[1]");
while (my $line1=<FILE1>){
    chomp $line1;
    if ($line1 =~ /^#/) {next;}
    my @gt=split(/\s+/,$line1);
    push @{$data{$gt[4]}}, [$gt[5], $gt[6]];
}
close(FILE1);


open(FILE, "$ARGV[0]");
while (my $line=<FILE>){

    chomp $line;
    &SCENE($line)

}

sub SCENE{
    my @csk=split(/\s+/,$_[0]);

    my $length=0;
    my $region=$csk[2]-$csk[1]+1;

    if (exists $data{$csk[0]}) {
        foreach my $interval (@{$data{$csk[0]}}) {
            if ($interval->[1] >= $csk[1] && $interval->[0] <= $csk[2]) {
                my $start = ($interval->[0] > $csk[1]) ? $interval->[0] : $csk[1];
                my $end = ($interval->[1] < $csk[2]) ? $interval->[1] : $csk[2];
                $length += $end - $start + 1;
            }
        }
    }

    my $fraction = ($region > 0) ? $length / $region : 0;
    print "$_[0]\t$region\t$length\t$fraction\n";

    return;
}
