#!/usr/bin/perl

use warnings;
use strict;
use lib "./scripts";
use common;

sub check_args {
 my $x = scalar @_;
 if ($x != 1) {
  print "Arguments:  input_codes\n" .
        "            input_codes.txt is a tab separated file of code values\n";
  die "" ;
 }
 if (! (-e "$_[0].txt") ) {
  print "The expected input file $_[0].txt does not exist.\n\n";
  check_args();
 }
 if (! (-e "$_[0].txt") ) {
  print "The expected input file $_[0].metadata.txt does not exist.\n\n";
  check_args();
 }
}

sub process_line {
 my ($line, %fields) = @_;

 my $code         = common::safe_lookup($line, "code",         %fields);
 my $display      = common::safe_lookup($line, "display",      %fields);
 my $codingScheme = common::safe_lookup($line, "codingScheme", %fields);
 my $system       = common::safe_lookup($line, "system",       %fields);

 print "   <concept>\n" .
       "    <code value=\"$code\"/>\n" .
       "    <display value=\"$display\"/>\n" .
       "   </concept>\n";
}

sub start_compose {
 my ($system) = @_;

 print " <compose>\n" .
       "  <include>\n" .
       "   <system value=\"$system\"/>\n";
}

sub end_compose {
 print "  </include>\n" .
       " </compose>\n";
}

# Main starts here

check_args @ARGV;

my ($input_file_stub) = @ARGV;

my $tab_file      = $input_file_stub . ".txt";
my $metadata_file = $input_file_stub . ".metadata.txt";

my @lines    = common::read_lines($tab_file, 1);
my @metadata = common::read_lines($metadata_file);

my ($codeName, $classScheme) = common::process_line_1(shift @lines);
my %fields                   = common::process_line_2(shift @lines);

common::output_value_set_open($codeName, $classScheme);
common::output_lines(@metadata);

my $system_index = common::find_column_index("system", %fields);
my $system       = common::find_unique($system_index, @lines);
print "$system\n";

start_compose($system);
foreach (@lines) {
 process_line($_, %fields);
}

end_compose();
common::output_value_set_close();
