# Before 'make install' is performed this script should be runnable with
# 'make test'. After 'make install' it should work as 'perl Async-Go.t'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use strict;
use warnings;

use Test::More tests => 3;
use Test::Exception;
BEGIN { use_ok('Async::Go') };

throws_ok { my $chan = make_chan(undef,0) }
    qr/^Async::Go::Channel::Array does not support unbuffered channels. Specify capacity > 0./,
    'Cannot create unbuffered channels';

{
    my $chan = make_chan(undef,1);
    $chan->put('foo');
    my $read = $chan->get();
    is($read,'foo');
}
