use strict;
use warnings;

package WebService::IMDBAPI;

# ABSTRACT: Interface to http://imdbapi.org/

use WebService::IMDBAPI::Result;

use LWP::UserAgent;
use JSON;

use Data::Dumper;

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

    # TODO: parse options (merge hash?)

    # TODO: get from options
    my $url = $self->_generate_url(
        {
            title   => $title,
            plot    => 'simple',
            limit   => 1,
            aka     => 'simple',
            release => 'simple'
        }
    );

    my $ua = LWP::UserAgent->new();
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

  # TODO

=head1 DESCRIPTION

TODO

=cut
