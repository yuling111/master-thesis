#!/usr/bin/perl -w
#  Author: Paul Horton
#  Created: 20210909
#  Updated: 20210909
#
#  Description:  Clean up some temporary latex files.
#
use feature qw(say);
use strict;
use warnings;


my $usage  =  "Usage: $0 [-n] latex-file...";


die $usage   if  grep {/^-h/} @ARGV;

@ARGV  and  $ARGV[0] eq '-n'  and   my $dryRunP= shift @ARGV;

@ARGV  or  die $usage;


for my $filename (@ARGV){
    $filename=~ /[.]tex$/  or  die  "Expected tex filename but got '$filename'";
    
    my $filenameStem=  $filename=~ s/[.]tex$//r;

    for( qw(aux bbl bcf blg ilg log lof lot nlo nls out run.xml toc xdv) ){
        if( -e "$filenameStem.$_" ){
            say  "rm $filenameStem.$_";
            system  "rm $filenameStem.$_"   unless $dryRunP;
        }
    }
}
