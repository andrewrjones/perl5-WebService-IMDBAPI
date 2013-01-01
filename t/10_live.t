#!perl

use strict;
use warnings;

use Test::More;

# skip tests if we are not online
use HTTP::Online ':skip_all';

plan tests => 4;

use WebService::IMDBAPI;

my $title   = 'The Notebook';
my $imdb_id = 'tt0332280';
my $imdbapi;
my $result;

$imdbapi = WebService::IMDBAPI->new();

$result = $imdbapi->search_by_title($title);
is( $result->title,   $title );
is( $result->imdb_id, $imdb_id );

SKIP: {
    skip "TODO", 2;
    $result = $imdbapi->search_by_id($imdb_id);
    is( $result->title,   $title );
    is( $result->imdb_id, $imdb_id );
}
