#!/usr/bin/perl

use warnings;
use strict;
use lib "./scripts";
use common;

sub check_args {
 my $x = scalar @_;
 if ($x > 1) {
  print "Arguments: [path]\n" .
        "           path is an optional argument directing output to that location\n" .
        "            Default path is ./generated/common\n";
  die "" ;
 }
}

sub get_code_files {
# In order of original codes.xml to stay consistent with XDS Toolkit / codes.xml
 my @codeFiles = (
	"confidentiality_code.txt",
	"healthcare_facility_type_code.txt",
	"event_code_list.txt",
	"practice_setting_code.txt",
	"folder_code_list.txt",
	"association_documentation.txt",
	"type_code.txt",
	"content_type_code.txt",
	"class_code.txt",
	"format_code.txt",

 );
 return @codeFiles;
}

sub output_comments {
 my ($fh, $commentFile) = @_;
 if (-e $commentFile) {
  my @lines = common::read_lines($commentFile);
  foreach (@lines) {
   print $fh "$_\n";
  }
 }
}

sub process_one_value_set {
 my ($fh, $inputFile) = @_;
 my @lines = common::read_lines($inputFile, 1);

 my ($codeName, $classScheme) = common::process_line_1(shift @lines);
 my %fields                   = common::process_line_2(shift @lines);

 common::output_code_type_open($fh, $codeName, $classScheme);

 foreach (@lines) {
  my $code         = common::safe_lookup($_, "code",         %fields);
  my $display      = common::safe_lookup($_, "display",      %fields);
  my $codingScheme = common::safe_lookup($_, "codingScheme", %fields);
  my $system       = common::safe_lookup($_, "system",       %fields);

  print $fh
        "  <Code" .
        " code=\"$code\"" .
        " display=\"$display\"" .
        " codingScheme=\"$codingScheme\"" .
        " system=\"$system\"" .
        "/>\n";
  }
 common::output_code_type_close($fh);
}

sub process_mime_type {
 my ($fh, $inputFile) = @_;
 my @lines = common::read_lines($inputFile,1);

 my ($codeName) = common::process_line_1(shift @lines);
 my %fields     = common::process_line_2(shift @lines);

 common::output_code_type_open($fh, $codeName);

 foreach (@lines) {
  my $code         = common::safe_lookup($_, "code",         %fields);
  my $ext          = common::safe_lookup($_, "ext",          %fields);

  print $fh
        "  <Code " .
        " code=\"$code\"" .
        " ext=\"$ext\"" .
        "/>\n";
 }
 common::output_code_type_close($fh);
}

sub process_assigning_authority {
 my ($fh, $inputFile) = @_;
 my @lines = common::read_lines($inputFile,1);

 my ($codeName) = common::process_line_1(shift @lines);
 my %fields     = common::process_line_2(shift @lines);

 foreach (@lines) {
  my $code         = common::safe_lookup($_, "code",         %fields);
  my $display      = common::safe_lookup($_, "display",      %fields);

  print $fh
        "  <AssigningAuthority" .
        " id=\"$code\"" .
        " display=\"$display\"" .
        "/>\n";
 }
}

check_args @ARGV;

my $outputPath = ((scalar @ARGV) == 1) ? $ARGV[0] : "./generated/common";

common::create_folder_or_die($outputPath);
my $outputFile = $outputPath ."/codes.xml";

open (my $fh, ">$outputFile") or die "Could not create output file: $outputFile\n";

my $folder = "value_sets/common";

my @codeFiles = get_code_files();

print $fh "<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?>\n";
output_comments($fh, "$folder/codes.xml.history.txt");

print $fh "<Codes>\n";
foreach (@codeFiles) {
 process_one_value_set($fh, "$folder/$_");
}

process_mime_type          ($fh, "$folder/mime_type.txt");
process_assigning_authority($fh, "$folder/assigning_authority.txt");

print $fh "</Codes>\n";

close $fh;
