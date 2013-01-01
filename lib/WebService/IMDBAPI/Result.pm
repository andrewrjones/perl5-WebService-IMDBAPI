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
  langauge
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

See http://imdbapi.org/#fields for details of the attributes contained in this object. Each field from the API is an attribute.

=cut
