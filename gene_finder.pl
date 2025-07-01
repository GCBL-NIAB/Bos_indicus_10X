#!/usr/bin/perl                                         

open(FILE,"$ARGV[0]");   
                        

while ($line=<FILE>)  {



&GENE_NAME($line);





}



sub GENE_NAME {


@mi=split (/\s+/,$_[0]);

open (FILE1,"$ARGV[1]");
my $signal=0;
while (my $line1=<FILE1>){
chomp $line1;
@csk=split (/\s+/,$line1);

if ($csk[2] eq "gene" &&$csk[0] eq "$mi[0]" ){ 
						if ($csk[3] >$mi[1] && $csk[4] <$mi[2]){print "$mi[0]_$mi[1]-$mi[2]-$mi[3]\t$line1\n";$signal=5;next;}
						elsif($csk[3] < $mi[1] && $csk[4] >$mi[1]){print "$mi[0]_$mi[1]-$mi[2]-$mi[3]\t$line1\n";$signal=5;next;}
						elsif($csk[3] < $mi[2] && $csk[4] >$mi[2]){print "$mi[0]_$mi[1]-$mi[2]-$mi[3]\t$line1\n";$signal=5;next;}
						else{next;}
								
						}

}

return;
}
