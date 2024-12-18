package App::Tickit::Hello;

use strict;
use warnings;

use Getopt::Std;
use List::Util 1.33 qw(none);
use Readonly;
use Tickit;
use Tickit::Widget::Static;

Readonly::Array our @HORIZONTAL_ALIGNS => qw(left center right);
Readonly::Array our @VERTICAL_ALIGNS => qw(top middle bottom);

our $VERSION = 0.01;

# Constructor.
sub new {
	my ($class, @params) = @_;

	# Create object.
	my $self = bless {}, $class;

	# Object.
	return $self;
}

# Run.
sub run {
	my $self = shift;

	# Process arguments.
	$self->{'_opts'} = {
		'a' => 'center',
		'b' => 'black',
		'f' => 'green',
		'h' => 0,
		'v' => 'middle',
	};
	if (! getopts('a:b:f:hv:', $self->{'_opts'})
		|| $self->{'_opts'}->{'h'}) {

		print STDERR "Usage: $0 [-a horiz_align] [-b bg_color] [-f fg_color] [-h] [-v vert_align] [--version]\n";
		print STDERR "\t-a horiz_align\tHorizontal align (left, center - default, right).\n";
		print STDERR "\t-b bg_color\tBackground color (default is black).\n";
		print STDERR "\t-f fg_color\tForeground color (default is green).\n";
		print STDERR "\t-h\t\tPrint help.\n";
		print STDERR "\t-v vert_align\tVertical align (top, middle - default, bottom).\n";
		print STDERR "\t--version\tPrint version.\n";
		return 1;
	}
	my $message = $ARGV[0] || 'Hello world!';

	# Horizontal align.
	if (none { $self->{'_opts'}->{'a'} eq $_ } @HORIZONTAL_ALIGNS) {
		print STDERR "Bad horizontal align.\n";
		return 1;
	}
	# XXX Tickit::Widget::Static uses 'centre'.
	$self->{'_opts'}->{'a'} =~ s/center/centre/;

	# Vertical align.
	if (none { $self->{'_opts'}->{'v'} eq $_ } @VERTICAL_ALIGNS) {
		print STDERR "Bad vertical align.\n";
		return 1;
	}

	my $style_hr = {};
	if (defined $self->{'_opts'}->{'b'}) {
		$style_hr->{'bg'} = $self->{'_opts'}->{'b'};
	}
	if (defined $self->{'_opts'}->{'f'}) {
		$style_hr->{'fg'} = $self->{'_opts'}->{'f'};
	}
	my $widget = Tickit::Widget::Static->new(
		'align' => $self->{'_opts'}->{'a'},
		'style' => $style_hr,
		'text' => $message,
		'valign' => $self->{'_opts'}->{'v'},
	);

	Tickit->new('root' => $widget)->run;

	return 0;
}

1;

__END__
