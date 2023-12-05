#!/usr/bin/perl

use strict; use warnings;

# Open and read input file
my $filename = "input.txt";
open(my $file, '<', $filename) or die "Could not open file '$filename' for reading: $!";

# Got the letter hack from reddit
my %value_mapping = (
  'one' => '1e',
  'two' => '2o',
  'three' => '3e',
  'four' => '4r',
  'five' => '5e',
  'six' => '6x',
  'seven' => '7n',
  'eight' => '8t',
  'nine' => '9e',
);

# Iterate over each line in the file
my $sum = 0;
while (my $line = <$file>) {
  chomp($line); # Remove the newline character

  # Replace any matches of spelled out numbers
  # Comment out to get part 1 answer
  my $pattern = join('|', map { quotemeta } keys %value_mapping);
  my @map_matches = $line =~ /($pattern)/g;
  while (@map_matches) {
    $line =~ s/($pattern)/$value_mapping{$1} || $1/ge;
    @map_matches = $line =~ /($pattern)/g;
  }

  # Find the first and last digit and add to sum
  my @matches = $line =~ /\d/g;
  my $first_item = $matches[0];
  my $last_item = $matches[$#matches];
  my $value = int("$first_item$last_item");
  $sum = $sum + $value;
}
print "$sum\n";

# Close the file
close($file) or die "Could not close file '$filename': $!";
