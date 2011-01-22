use strict;
use warnings;
package Test::Bomb;
# ABSTRACT: a test which succeeds until a deadline passes ( a time bomb )

use Exporter qw/import/;
use Date::Parse;
use Test::More;

our @EXPORT = qw/ bomb /;

=head1 NAME

Test::Bomb

=head1 SYNOPSIS

use this test to ignore part of your system until
a deadline passes.  After the deadline the test will
fail unless you replace it.   I use it for large 
projects where I want to forget about some subsystems
until after other parts are done.

usage( in a test script ):

    bomb -after => 'Jan 31 2011';

before Jan 31 prints:

    ok 1 - bomb after Jan 31 2011

after deadline prints

    nok 1 - deadline passed

=head1 NOTE

this is a development tool.  if you release code that uses this test
I expect you will have some very upset users.

=head TODO

=over

=item 1

add some kind of check to see if the user is building a release.  if that
is the case then fail.

=item 2

some way to centralize expiration dates; a configuration file with a name to
date map so that I can have many tests that will fail on the same day and if
I'm too busy that day I can just edit the config file and the tests will all 
pass again...

=back

=head1 EXPORT

bomb is automatically exported; if you don't want to use the function
why did you use the package?

=head1 SUBROUTINES/METHODS

=head2 bomb -after => 'date to expire'

acts like a test; 
errors cause test failure

=cut

sub bomb {
    local( $Test::Builder::Level ) = 2;
    if( $_[0] eq '-after' ) {
        my $stringDate = $_[1];
        my $time = str2time($stringDate);
        ok(0, "invalid date: '$stringDate'"), return unless $time;
        my $res = time < $time;
        my $name;
        if( $res ) { $name = "bomb after $stringDate" }
        else { $name = 'deadline passed' }
        ok $res, $name ;
    } else {
        ok 0, 'invalid parameter: \''. $_[0] . "'";
    }
    return 0
}

=head1 AUTHOR

David Delikat, C<< <david-delikat at usa.net> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-temp at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=temp>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc temp


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=temp>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/temp>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/temp>

=item * Search CPAN

L<http://search.cpan.org/dist/temp/>

=back


=head1 ACKNOWLEDGEMENTS


=head1 LICENSE AND COPYRIGHT

Copyright 2011 David Delikat.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.


=cut

1;

