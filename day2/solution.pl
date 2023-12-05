#!/usr/bin/perl

use strict; use warnings;

# Open and read input file
my $filename = "input.txt";
open(my $file, '<', $filename) or die "Could not open file '$filename' for reading: $!";

my %cube_limits = (
  'red' => 12,
  'green' => 13,
  'blue' => 14,
);

my $sum = 0;
while (my $line = <$file>) {
  chomp($line);

  $line =~ s/Game (\d*): //g;
  my $game_number = $1;
  my $game_possible = 1;
  my @cube_sets = split('; ', $line);
  foreach my $cube_set (@cube_sets) {
    my @cube_vals = split(', ', $cube_set);
    foreach my $cube_val (@cube_vals) {
      my @cubes = split(' ', $cube_val);
      if(int($cubes[0]) > $cube_limits{$cubes[1]}) {
        $game_possible = 0;
        last;
      }
    }
    if(!$game_possible) {
      last;
    }
  }
  if($game_possible) {
    $sum += int($game_number);
  }
}
print "$sum\n";

# Close the file
close($file) or die "Could not close file '$filename': $!";
