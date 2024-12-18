package App::Tickit::Hello;

use strict;
use warnings;

use Getopt::Std;
use List::Util 1.33 qw(none);
use Readonly;
use Tickit;
use Tickit::Widget::Static;

Readonly::Array our @HORIZONTAL_ALIGNS => qw(left center right);

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
		'a' => 'left',
		'h' => 0,
	};
	if (! getopts('a:h', $self->{'_opts'})
		|| $self->{'_opts'}->{'h'}) {

		print STDERR "Usage: $0 [-a horiz_align] [-h] [--version]\n";
		print STDERR "\t-a horiz_align\tHorizontal align (left - default, center, right).\n";
		print STDERR "\t-h\t\tPrint help.\n";
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

	my $widget = Tickit::Widget::Static->new(
		'align' => $self->{'_opts'}->{'a'},
		'text' => $message,
	);

	Tickit->new('root' => $widget)->run;

	return 0;
}

1;

__END__
