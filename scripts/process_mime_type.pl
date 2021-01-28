#!/usr/bin/perl

use warnings;
use strict;
use lib "./scripts";
use common;

sub check_args {
 my $x = scalar @_;
 if ($x != 2) {
  print "Arguments:  input_codes.txt output_codes.xml\n" .
        "            input_codes.txt is a tab separated file of code values\n" .
        "            output_codes.xml is an XML file that matches the format for XDSD toolkit / codes.xml\n";
  die "" ;
 }
 if (! (-e $_[0]) ) {
  print "The expected input file $_[0] does not exist.\n\n";
  check_args("a");
 }
}

sub outputCodeType {
 my ($codeName) = @_;
 print " <CodeType name=\"$codeName\">\n";
}

sub outputClose {
 print " </CodeType>\n";
}

sub process_line {
 my ($line, %fields) = @_;

 my $code         = common::safe_lookup($line, "code",         %fields);
 my $ext          = common::safe_lookup($line, "ext",          %fields);

 print "  <Code " .
       " code=\"$code\"" .
       " ext=\"$ext\"" .
       "/>\n";
}

# Main starts here

check_args @ARGV;

my ($input_file, $output_file) = @ARGV;

my @lines = common::read_lines($input_file);

my ($codeName) = common::process_line_1(shift @lines);
my %fields     = common::process_line_2(shift @lines);

common::output_code_type_open($codeName);

foreach (@lines) {
 process_line($_, %fields);
}

common::output_code_type_close();
