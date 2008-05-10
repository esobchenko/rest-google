#
# $Id: Search.pm 9 2008-04-29 21:17:12Z esobchenko $

package REST::Google::Search;

use strict;
use warnings;

use version; our $VERSION = qv('1.0.2');

use constant {
	WEB => 'http://ajax.googleapis.com/ajax/services/search/web',
	VIDEO => 'http://ajax.googleapis.com/ajax/services/search/video',
	NEWS => 'http://ajax.googleapis.com/ajax/services/search/news',
	LOCAL => 'http://ajax.googleapis.com/ajax/services/search/local',
	IMAGES => 'http://ajax.googleapis.com/ajax/services/search/images',
	BOOKS => 'http://ajax.googleapis.com/ajax/services/search/books',
	BLOGS => 'http://ajax.googleapis.com/ajax/services/search/blogs',
};

require Exporter;
require REST::Google;
use base qw/Exporter REST::Google/;

our @EXPORT_OK = qw/WEB VIDEO NEWS LOCAL IMAGES BOOKS BLOGS/;

__PACKAGE__->service( WEB );

sub responseData {
	my $self = shift;
	return bless $self->{responseData}, 'REST::Google::Search::Data';
}

package # hide from CPAN
	REST::Google::Search::Data;

sub results {
	my $self = shift;
	return map { bless $_, $_->{GsearchResultClass} } @{ $self->{results} };
}

sub cursor {
	my $self = shift;
	return bless $self->{cursor}, 'REST::Google::Search::Cursor';
}

package # hide from CPAN
	REST::Google::Search::Cursor;

use base qw/Class::Accessor/;

{
	my @fields = qw(
		estimatedResultCount
		currentPageIndex
		moreResultsUrl
	);

	__PACKAGE__->mk_ro_accessors( @fields );
}

# XXX original 'pages' entry contains array of hashes.
sub pages {
	my $self = shift;
	my $pages = $self->{pages};
	return scalar @{ $pages };
}

#
# Search Result Classes
#

package # hide from CPAN 
	GwebSearch;

use base qw/Class::Accessor/;

{
	my @fields = qw(
		GsearchResultClass
		unescapedUrl
		url
		visibleUrl
		cacheUrl
		title
		titleNoFormatting
		content
	);

	__PACKAGE__->mk_ro_accessors( @fields );
}

package # hide from CPAN
	GvideoSearch;

use base qw/Class::Accessor/;

{
	my @fields = qw(
		title
		titleNoFormatting
		content
		url
		published
		publisher
		duration
		tbWidth
		tbHeight
		tbUrl
		playUrl
	);

	__PACKAGE__->mk_ro_accessors( @fields );
}

package # hide from CPAN
	GnewsSearch;

use base qw/Class::Accessor/;

{
	my @fields = qw(
		title
		titleNoFormatting
		unescapedUrl
		url
		clusterUrl
		content
		publisher
		location
		publishedDate
		relatedStories
	);

	__PACKAGE__->mk_ro_accessors( @fields );
}

package # hide from CPAN
	GlocalSearch;

use base qw/Class::Accessor/;

{
	my @fields = qw(
		title
		titleNoFormatting
		url
		lat
		lng
		streetAddress
		city
		region
		country
		phoneNumbers
		ddUrl
		ddUrlToHere
		ddUrlFromHere
		staticMapUrl
	);

	__PACKAGE__->mk_ro_accessors( @fields );
}

package # hide from CPAN
	GimageSearch;

use base qw/Class::Accessor/;

{
	my @fields = qw(
		title
		titleNoFormatting
		unescapedUrl
		url
		visibleUrl
		originalContextUrl
		width
		height
		tbWidth
		tbHeight
		tbUrl
		content
		contentNoFormatting
	);

	__PACKAGE__->mk_ro_accessors( @fields );
}

package # hide from CPAN
	GbookSearch;

use base qw/Class::Accessor/;

{
	my @fields = qw(
		title
		titleNoFormatting
		unescapedUrl
		url
		authors
		bookId
		publishedYear
		pageCount
		thumbnailHtml
	);

	__PACKAGE__->mk_ro_accessors( @fields );
}

package # hide from CPAN
	GblogSearch;

use base qw/Class::Accessor/;

{
	my @fields = qw(
		title
		titleNoFormatting
		postUrl
		content
		author
		blogUrl
		publishedDate
	);

	__PACKAGE__->mk_ro_accessors( @fields );
}

1;
