use strict;
use warnings;

package WebService::IMDBAPI::Result;

# ABSTRACT: Represents a result

# Assessors
# alphabetically, case insensitive
use Object::Tiny qw(
  actors
  also_known_as
  country
  directors
  episodes
  film_locations
  genres
  imdb_id
  imdb_url
  language
  plot
  plot_simple
  poster
  rated
  rating
  rating_count
  release_date
  runtime
  title
  type
  writers
  year
);

1;

__END__

=head1 DESCRIPTION

See http://imdbapi.org/#fields for details of the attributes contained in this object.

Note that the presence and contents of some of these attributes can differ depending on the options passed to the search.

=attr actors

=attr also_known_as

=attr country

=attr directors

=attr episodes

=attr film_locations

=attr genres

=attr imdb_id

=attr imdb_url

=attr language

=attr plot

=attr plot_simple

=attr poster

=attr rated

=attr rating

=attr rating_count

=attr release_date

=attr runtime

=attr title

=attr type

=attr writers

=attr year

=cut
