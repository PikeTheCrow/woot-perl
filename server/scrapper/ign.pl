#! /usr/bin/env perl

use strict;
use warnings;
use Data::Dumper;

use WWW::Mechanize;
use XML::LibXML;

my $url = 'http://www.ign.com/';

my $mech = WWW::Mechanize->new();
$mech->get ( $url );

my $doc = XML::LibXML->load_xml(
    string  =>  $mech->content,
    recover =>  1
);

my $xpc = XML::LibXML::XPathContext->new($doc->documentElement);

print $xpc;