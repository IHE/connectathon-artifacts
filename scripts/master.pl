#!/usr/bin/perl

use warnings;
use strict;
use lib "./scripts";
use common;

sub check_args {
 my $x = scalar @_;
 if ($x > 1) {
  print "Arguments: [path]\n" .
        "           path is an optional argument directing output to that location\n";
  die "" ;
 }
}

sub check_for_scripts {
 my @missingScripts;
 foreach (@_) {
  my @tokens = split(/\t/, $_);
  my $scriptName = "scripts/$tokens[0].pl";
  push (@missingScripts, $_) if (! -e $scriptName);
 }
 if (scalar(@missingScripts) != 0) {
  foreach (@missingScripts) {
   print "Did not find a script file for: $_\n";
  }
  die "One or more scripts referenced in the master file were not found in the scripts folder.\n";
 }
}

# Main starts here

check_args @ARGV;
my $path = ((scalar @ARGV) == 1) ? $ARGV[0] : ".";

my @lines    = common::read_lines("master.txt", 1);

# Make sure all lines name a script that exists
check_for_scripts(@lines);

# Process each line separately. We just invoke a perl script.

foreach (@lines) {
 my ($scriptName, $relativePath) = common::safe_split(/\t/, $_, 2);
 $scriptName = "scripts/$scriptName.pl";
 my $x = "perl $scriptName $path/$relativePath";
 print "About to execute: $x\n";

 print `$x`;
 die "Could not execute $x" if $?;
}
