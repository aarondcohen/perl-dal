package DAL::Proxy::Cache;

use parent 'DAL::Proxy';

sub new {
	my ($class, %args) = @_;
	$class = ref $class || $class;
	bless $class->SUPER::new(%args, proxy => $args{cache_layer}), $class;
}

sub cache_layer { (shift)->proxy }

1;
