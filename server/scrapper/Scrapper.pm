#! /usr/bin/env perl

package Scrapper;

use strict;
use warnings;

use Moo;
use Carp qw(confess);
use WWW::Mechanize;
use XML::LibXML;

has url => (
    is  => 'rw',
    isa => sub {
        confess "'$_[0]' is not an URL!"
            if $_[0] !~ /^\w+:\/\/(www.|)\w+.\w+(\/|)$/;
    },
);

sub response {
    my $self = shift;
    
    my $mech = WWW::Mechanize->new();
    $mech->get($self->url);

    return $mech->success ? $mech : confess "$mech->status";
}

sub parse {
    my $self = shift;
    
    my $dom = XML::LibXML->load_html(
        string  => $self->content
    );

    return $dom;
}

1