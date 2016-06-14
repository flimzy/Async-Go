package Async::Go::Channel::Array;
use strict;
use warnings;

use parent 'Async::Go::Channel';
use Carp qw( croak );

sub new {
    my ( $class, $type, $cap ) = @_;
    if ( $cap == 0 ) {
        croak("Async::Go::Channel::Array does not support unbuffered channels. Specify capacity > 0.");
    }
    return bless {
        type        => $type,
        storage     => [],
        capacity    => $cap,
    }, $class;
}

sub put {
    my ( $self, $value ) = @_;
    if ( @{ $self->{'storage'} } >= $self->{'capacity'} ) {
        croak("Channel capacity exceeded. Async::Go::Channel::Array does not support blocking operation.");
    }
    push @{ $self->{'storage'} }, $value;
    if ( @{ $self->{'storage'} } > $self->{'capacity'} ) {
        croak("Channel capacity exceeded. Async::Go::Channel::Array does not support blocking operation.");
    }
}

sub get {
    my ( $self ) = @_;
    if ( @{ $self->{'storage'} } == 0 ) {
        croak("Channel is empty for reading. Async::Go::Channel::Array does not support blocking operation.");
    }
    return shift @{ $self->{'storage'} };
}

=head1 NAME

Async::Go::Channel::Array - A simple reference implementation of channels,
which does not support IPC. Intended for testing.

=head1 AUTHOR

Jonathan Hall, E<lt>jonhall@E<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2016 by Jonathan Hall

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.20.2 or,
at your option, any later version of Perl 5 you may have available.

=cut

1;
