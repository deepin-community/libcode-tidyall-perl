package Code::TidyAll::Result;

use strict;
use warnings;

use Specio::Declare;
use Specio::Library::Path::Tiny;
use Specio::Library::String;

use Moo;

our $VERSION = '0.78';

has error => (
    is  => 'ro',
    isa => t('NonEmptyStr'),
);

has new_contents => (
    is  => 'ro',
    isa => t('NonEmptyStr'),
);

has orig_contents => (
    is  => 'ro',
    isa => t('NonEmptyStr'),
);

has path => (
    is  => 'ro',
    isa => t('Path'),
);

has state => (
    is  => 'ro',
    isa => enum( values => [qw( cached checked error no_match tidied)] ),
);

sub ok { return $_[0]->state ne 'error' }

1;

# ABSTRACT: Result returned from processing a file/source

__END__

=pod

=encoding UTF-8

=head1 NAME

Code::TidyAll::Result - Result returned from processing a file/source

=head1 VERSION

version 0.78

=head1 SYNOPSIS

    my $ct = Code::TidyAll->new(...);
    my $result = $ct->process_file($file);
    if ($result->error) {
       ...
    }

=head1 DESCRIPTION

Represents the result of C<< Code::TidyAll->process_file >> and C<<
Code::TidyAll->process_file >>. A list of these is returned from C<
Code::TidyAll->process_paths >>.

=head1 METHODS

This class provides the following methods:

=head2 $result->path

The path that was processed, relative to the root (e.g. "lib/Foo.pm")

=head2 $result->state

A string, one of

=over 4

=item * C<no_match> - No plugins matched this file

=item * C<cached> - Cache hit (file had not changed since last processed)

=item * C<error> - An error occurred while applying one of the plugins

=item * C<checked> - File was successfully checked and did not change

=item * C<tidied> - File was successfully checked and changed

=back

=head2 $result->orig_contents

Contains the original contents if state is 'tidied' and with some errors (like
when a file needs tidying in check-only mode)

=head2 $result->new_contents

Contains the new contents if state is 'tidied'

=head2 $result->error

Contains the error message if state is 'error'

=head2 $result->ok

Returns true iff state is not 'error'

=head1 SUPPORT

Bugs may be submitted at
L<https://github.com/houseabsolute/perl-code-tidyall/issues>.

I am also usually active on IRC as 'autarch' on C<irc://irc.perl.org>.

=head1 SOURCE

The source code repository for Code-TidyAll can be found at
L<https://github.com/houseabsolute/perl-code-tidyall>.

=head1 AUTHORS

=over 4

=item *

Jonathan Swartz <swartz@pobox.com>

=item *

Dave Rolsky <autarch@urth.org>

=back

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 - 2020 by Jonathan Swartz.

This is free software; you can redistribute it and/or modify it under the same
terms as the Perl 5 programming language system itself.

The full text of the license can be found in the F<LICENSE> file included with
this distribution.

=cut
