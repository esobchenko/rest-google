#
# $Id$

use strict;

use Test::More tests => 4;

use REST::Google::Search;

REST::Google::Search->http_referer('http://www.cpan.org');

use Data::Dumper;

# empty searsh
# defect #37213 by Xuerui Wang
my $search = REST::Google::Search->new( q => '' );

is($search->responseStatus, 200, "status");
my $data = $search->responseData;
ok(defined $data, "data");
my $cursor = $data->cursor;
ok(defined $cursor, "cursor");
my $pages = $cursor->pages;
is($pages, 0, "pages");

