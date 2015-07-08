package DAL::Proxy::Storage;

use parent 'DAL';

sub new {
	my ($class, %args) = @_;
	$class = ref $class || $class;
	bless $class->SUPER::new(%args, proxy => $args{storage_layer}), $class;
}

sub storage_layer { (shift)->proxy }

1;
