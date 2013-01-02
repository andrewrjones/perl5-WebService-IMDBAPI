use strict;
use warnings;

package WebService::IMDBAPI;

# ABSTRACT: Interface to http://imdbapi.org/

use WebService::IMDBAPI::Result;

use LWP::UserAgent;
use JSON;

# default options
use constant DEFAULT_USER_AGENT => 'Mozilla/5.0';
use constant DEFAULT_LANG       => 'en-US';

use constant BASE_URL => 'http://imdbapi.org/?type=json';

use Object::Tiny qw(
  user_agent
  language
);

sub new {
    my $class = shift;
    my $self  = $class->SUPER::new(@_);

    unless ( $self->user_agent ) {
        $self->{user_agent} = DEFAULT_USER_AGENT;
    }
    unless ( $self->language ) {
        $self->{language} = DEFAULT_LANG;
    }

    return $self;
}

sub search_by_title {
    my ( $self, $title, $options ) = @_;

    unless ($title) {

        # TODO: do something
    }
    $options->{title} = $title;

    my $url = $self->_generate_url($options);
    my $ua  = LWP::UserAgent->new();
    $ua->agent( $self->{user_agent} );
    my $response = $ua->get($url);

    if ( $response->is_success ) {

        # TODO: will this work if we have more than one result?
        my $result = WebService::IMDBAPI::Result->new(
            %{ decode_json( $response->content )->[0] } );
        return $result;
    }
    else {
        die $response->status_line;
    }
}

sub search_by_id {
    my ( $self, $id, $options ) = @_;
}

# carries out the search
sub _do_search {

    # TODO: extract out the search request functionality to here.
}

# generates a url from the options
sub _generate_url {
    my ( $self, $options ) = @_;

    my $url = sprintf( "%s&lang=%s", BASE_URL, $self->{language} );

    while ( my ( $key, $value ) = each(%$options) ) {
        $url .= sprintf( "&%s=%s", $key, $value );
    }

    return $url;
}

1;

__END__

=head1 SYNOPSIS

  my $imdb = WebService::IMDBAPI->new();
  
  # an array of up to 1 result
  my $results = $imdbapi->search_by_title('In Brugges', { limit => 1 });
  
  # an WebService::IMDBAPI::Result object
  my $result = $results->[0];
  
  say $result->title;
  say $result->plot_simple;

=head1 DESCRIPTION

WebService::IMDBAPI is an interface to L<http://imdbapi.org/>.

=method new

Creates a new WebService::IMDBAPI object. Takes the following optional parameters:

=over 4

=item user_agent

The user agent to use. Note that the default LWP user agent seems to be blocked. Defaults to C<Mozilla/5.0>.

=item language

The language for the results. Defaults to C<en-US>.

=back

=method search_by_title( $title, $options )

Searches based on a title. For the options and their defaults, see L<http://imdbapi.org/>.

Some of the most common options are:

=over 4

=item limit

Limits the number of results.

=back

Returns an array of L<WebService::IMDBAPI::Result> objects.

=method search_by_id( $id, $options )

Searches based on an IMDB ID. For the options and their defaults, see L<http://imdbapi.org/>.

Returns a single L<WebService::IMDBAPI::Result> object.

=cut
