package TestHelper::Plugin::RepeatFoo;

use Moo;
extends 'Code::TidyAll::Plugin';

has 'times' => ( is => 'ro' );

sub transform_source {
    my ( $self, $source ) = @_;
    my $times = $self->times || die "no times specified";
    return $source x $times;
}

1;
