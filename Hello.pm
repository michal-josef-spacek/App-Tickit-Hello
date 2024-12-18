package App::Tickit::Hello;

use strict;
use warnings;

use Getopt::Std;
use Tickit;
use Tickit::Widget::HelloWorld::Common;

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
		'h' => 0,
	};
	if (! getopts('h', $self->{'_opts'})
		|| $self->{'_opts'}->{'h'}) {

		print STDERR "Usage: $0 [-h] [--version] [message]\n";
		print STDERR "\t-h\t\tPrint help.\n";
		print STDERR "\t--version\tPrint version.\n";
		return 1;
	}
	my $message = $ARGV[0] || 'Hello world!';

	my $widget = Tickit::Widget::HelloWorld::Common->new(
		'text' => $message,
	);

	Tickit->new('root' => $widget)->run;

	return 0;
}

1;

__END__
