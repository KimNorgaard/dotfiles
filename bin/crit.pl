#!/opt/local/bin/perl -w
#
use Perl::Critic;
my $file = shift;
my $critic = Perl::Critic->new(-severity => 'brutal');
my @violations = $critic->critique($file);
print @violations;
