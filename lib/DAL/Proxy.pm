package DAL::Proxy;

use parent 'DAL';

sub new {
	my ($class, %args) = @_;
	$class = ref $class || $class;
	my $self = $class->SUPER::new(%args);

	$self->{_proxy} = $args{proxy};

	bless $self, $class;
}

sub proxy { (shift)->{_proxy} }

sub to_identifier  { (shift)->proxy->to_identifier(shift) }
sub to_identifiers { (shift)->proxy->to_identifiers(@_) }

sub _load         { (shift)->proxy->_load(shift) }
sub _load_multi   { (shift)->proxy->_load_multi(@_) }
sub _delete       { (shift)->proxy->_delete(shift) }
sub _delete_multi { (shift)->proxy->_delete_multi(@_) }
sub _save         { (shift)->proxy->_save(shift) }
sub _save_multi   { (shift)->proxy->_save_multi(@_) }

1;
