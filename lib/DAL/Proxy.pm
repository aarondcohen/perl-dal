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

sub instance_to_identifier   { (shift)->proxy->instance_to_identifier(shift) }
sub instances_to_identifiers { (shift)->proxy->instances_to_identifiers(shift) }

sub load         { (shift)->proxy->load(shift) }
sub load_multi   { (shift)->proxy->load_multi(@_) }
sub delete       { (shift)->proxy->delete(shift) }
sub delete_multi { (shift)->proxy->delete_multi(@_) }
sub save         { (shift)->proxy->save(shift) }
sub save_multi   { (shift)->proxy->save_multi(@_) }

1;
