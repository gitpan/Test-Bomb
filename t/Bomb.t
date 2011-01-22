
use Test::Tester;
use Test::More;

BEGIN { use_ok 'Test::Bomb' };

my $earlyTime = time - 5000;
my $lateTime = time + 5000;

=head test valid with failure

=cut

check_test(
    sub { bomb -after => '' . localtime( $earlyTime ) },
     { ok => 0, name => 'deadline passed', diag => '' },
     'valid w/ fail',
);

=head test valid with success

=cut

check_test(
    sub { bomb -after => '' . localtime( $lateTime ) },
    { ok => 1, name => 'bomb after ' . localtime( $lateTime ), diag => '' },
    'valid w/ success',
);

=head test invalid parameter

=cut

check_test(
    sub { bomb -bob => '' . localtime },
    { ok => 0, name => 'invalid parameter: \'-bob\'', diag => '' },
    'invalid param',
);

=head test invalid date

=cut

check_test(
    sub { bomb -after => 'bob' },
    { ok => 0, name => 'invalid date: \'bob\'', diag => '' },
    'invalid date',
);

=head TODO items in the module

=head1 test config file

=head1 test for release failure flag

=cut

done_testing;

