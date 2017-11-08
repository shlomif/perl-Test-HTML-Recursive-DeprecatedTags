package Test::HTML::Recursive::DeprecatedTags;

use strict;
use warnings;

use MooX qw/ late /;

extends('Test::HTML::Tidy::Recursive');

use HTML::TokeParser;

sub check_file
{
    my ( $self, $args ) = @_;

    my $fn = $args->{filename};
    my $p  = HTML::TokeParser->new($fn);
TOKENS:
    while ( my $token = $p->get_token )
    {
        if ( $token->[0] eq 'S' or $token->[0] eq 'E' )
        {
            if ( 'tt' eq lc $token->[1] )
            {
                $self->report_error( { message => "tt tag found in $fn ." } );
                last TOKENS;
            }
        }
    }

    return;
}

1;

__END__

=head1 NAME

Test::HTML::Recursive::DeprecatedTags - check HTML files for deprecated tags.

=head1 SYNOPSIS

In a test script for a web-site:

    use Test::HTML::Recursive::DeprecatedTags;

    Test::HTML::Recursive::DeprecatedTags->new(
        {
            targets         => ['./dest'],
        }
    )->run;

=head1 DESCRIPTION

This is a subclass of L<Test::HTML::Tidy::Recursive> so more information
can be found there.

=cut
