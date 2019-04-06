param ([int]$count = 6, [int]$sides = 6)

1..$count | % { get-random -Minimum 1 -Maximum ($sides + 1)}