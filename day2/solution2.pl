#!/usr/bin/perl

use strict; use warnings;
use List::Util qw(reduce);

# Open and read input file
my $filename = "input.txt";
open(my $file, '<', $filename) or die "Could not open file '$filename' for reading: $!";

my @powers = ();
while (my $line = <$file>) {
  chomp($line);

  my %cube_lows = (
    'red' => 0,
    'green' => 0,
    'blue' => 0,
  );

  $line =~ s/Game (\d*): //g;
  my $game_number = $1;
  my @cube_sets = split('; ', $line);
  foreach my $cube_set (@cube_sets) {
    my @cube_vals = split(', ', $cube_set);
    foreach my $cube_val (@cube_vals) {
      my @cubes = split(' ', $cube_val);
      my $cube_low = $cube_lows{$cubes[1]};
      if(int($cubes[0]) > $cube_low) {
        $cube_lows{$cubes[1]} = $cubes[0];
      }
    }
  }
  my @lows = values %cube_lows;
  my $power = reduce { $a * $b } @lows;
  push @powers, $power;
}
my $sum = reduce { $a + $b } @powers;
print "$sum\n";

# Close the file
close($file) or die "Could not close file '$filename': $!";
