#!perl

use strict;
use warnings;

use Test::More tests => 4;

BEGIN { use_ok('WebService::IMDBAPI'); }

my $imdbapi;    # WebService::IMDBAPI object

$imdbapi = WebService::IMDBAPI->new();
isa_ok( $imdbapi, 'WebService::IMDBAPI' );

# _generate_url()
my $got_url;
my $expected_url;

$expected_url = "http://imdbapi.org/?type=json&lang=en-US";
$got_url      = $imdbapi->_generate_url();
is( $got_url, $expected_url );

$expected_url = "http://imdbapi.org/?type=json&lang=en-US&foo=bar";
$got_url = $imdbapi->_generate_url( { foo => "bar" } );
is( $got_url, $expected_url );
