#
# $Id$

package REST::Google::Search::Patent;

use strict;
use warnings;

use version; our $VERSION = qv('1.0.7');

require REST::Google::Search;
use base qw/REST::Google::Search/;

__PACKAGE__->service( &REST::Google::Search::PATENT );

return 1;
