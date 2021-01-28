package common;

use warnings;
use strict;
use Exporter;
use File::Path qw(make_path);

our @ISA = qw(Exporter);
our @EXPORT_OK = qw(
    create_folder_or_die read_lines process_line_1 process_line_2
    output_code_type_open output_code_type_close output_value_set_open output_value_set
    close output_lines safe_lookup find_column_index find_unique safe_split);

sub create_folder_or_die {
 my ($path) = @_;
 return if (-e $path);
 die "No folder path specified in common::create_folder_or_die\n" if (! defined $path);

 make_path($path) or die "Could not create the folder specified by: $path\n";
}

sub read_lines {
 my ($path_to_file, $strip) = @_;
 open (my $handle, "<:encoding(utf8)", $path_to_file);

 my @lines;
 while (my $x = <$handle>) {
  chomp $x;
  if (defined $strip) {
   $x =~ s/^\s+|\s+$//g;
   $x =~ s/"//g;
  next if ($x eq "");
  }
  next if (substr($x, 0, 1) eq "#");
  push @lines, $x;
 }
 close $handle;
 return @lines;
}

sub process_line_1 {
 my ($line) = @_;
 my @tokens = split(/\t/, $line);
 return @tokens;
}

sub process_line_2 {
 my ($line) = @_;
 my @tokens = split(/\t/, $line);
 my $index = 0;
 my %fields;
 foreach (@tokens) {
  $fields{$_} = $index++;
 }
 return %fields;
}

sub output_code_type_open {
 my $fh = shift @_;

 my ($codeName, $classScheme) = @_;
 my $string = " <CodeType name=\"$codeName\"";
 $string .= " classScheme=\"$classScheme\"" if (defined $classScheme);
 $string .= ">\n";
 print $fh $string;
}

sub output_code_type_close {
 my ($fh) = @_;
 print $fh " </CodeType>\n";
}

sub output_value_set_open {
 my ($codeName, $classScheme) = @_;
 print "<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?>\n" .
       "<ValueSet xmlns=\"http://hl7.org/fhir\">\n";
}

sub output_value_set_close {
 print "</ValueSet>\n";
}

sub output_lines {
 my (@lines) = @_;

 foreach (@lines) {
  print "$_\n";;
 }
}

sub safe_lookup {
 my ($line, $fieldName, %fields) = @_;

 my @tokens = split(/\t/, $line);
 my $index = $fields{$fieldName};

 if (! defined $index) {
  my @keys = keys(%fields);
  foreach (@keys) {
   if ($fieldName eq $_) {
    print "fieldName match: $fieldName\n";
   }
   my $index = $fields{$_};
   print "Key: <$_> Index: <$index>\n";
  }
  die "Did not find an index for field: <$fieldName> in line: $line\n";
 }
 my $value = $tokens[$fields{"$fieldName"}];
 if (! (defined $value)) {
  die "Did not find a value for field: $fieldName in line: $line\n";
 }
 return $value;
}

sub find_unique {
 my ($field_index, @lines, %fields) = @_;
 my $unique_value = "";
 foreach (@lines) {
  my @tokens = split(/\t/, $_);
  my $v = $tokens[$field_index];
  die "No value for index: $field_index in line: $_\n" if (! defined $v);
  if ($unique_value eq "") {
   $unique_value = $v;
  }
  die "Value $v for index: $field_index in line: $_ does not match prior value: $unique_value\n" if (! ($v eq $unique_value));
 }
 return $unique_value;
}

sub find_column_index {
 my ($fieldName, %fields) = @_;
 my $index = $fields{$fieldName};
 die "Could not find an index for $fieldName\n" if (! defined $index);
 return $index;
}

sub safe_split {
 my ($delimiter, $line, $minimumArguments) = @_;

 my @tokens = split(/\t/, $line);
 my $count = scalar(@tokens);
 die "Expected $minimumArguments tokens, but only found $count in line: $line\n" if ($count < $minimumArguments);

 return @tokens;
}

#sub process_line {
# my ($line, %fields) = @_;
#
# my $code         = safe_lookup($line, "code",         %fields);
# my $ext          = safe_lookup($line, "ext",          %fields);
#
# print "  <Code " .
#       " code=\"$code\"" .
#       " ext=\"$ext\"" .
#       "/>\n";
#}
1;
