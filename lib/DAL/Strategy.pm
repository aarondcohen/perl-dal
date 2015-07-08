package DAL::Strategy;

use parent 'DAL';

my $str_identity = sub { "$_[0]" };

sub new {
	my ($class, %args) = @_;
	$class = ref $class || $class;
	my $self = $class->SUPER::new(%args);

	$self->{_cache_layer} = $args{cache_layer};
	$self->{_storage_layer} = $args{storage_layer};
	$self->{_identifier_to_string} = $args{identifier_to_string} || $str_identity;

	bless $self, $class;
}

sub cache_layer   { (shift)->{_cache_layer} }
sub storage_layer { (shift)->{_storage_layer} }

sub identifier_to_string { (shift)->{_identifier_to_string}->(shift) }


1;
