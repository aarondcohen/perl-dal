package DAL;

our $VERSION = '0.001';

sub new {
	my $class = shift;
	$class = ref $class || $class;
	return bless {}, $class;
}

##############################
# Helpers
##############################

sub to_identifier {
	my ($self, $instance) = (shift, shift);

	die "instance_to_identifier not implemented by ${\(ref $self)}";
}

sub to_identifiers {
	my $self = shift;

	return map { $self->to_identifier($_) } @_;
}

##############################
# Accesors
##############################

sub load {
	my ($self, $identifier) = (shift, shift);

	die "load not implemented by ${\(ref $self)}";
}

sub load_multi {
	my $self = shift;

	return map { $self->load($_) } @_;
}

sub reload {
	my ($self, $instance) = (shift, shift);

	return $self->load($self->to_identifier($instance));
}

sub reload_multi {
	my $self = shift;

	return $self->load_multi($self->to_identifiers(@_));
}

##############################
# Mutators
##############################

sub delete {
	my ($self, $instance) = (shift, shift);

	die "delete not implemented by ${\(ref $self)}";
}

sub delete_multi {
	my $self = shift;

	$self->delete($_) for @_;

	return;
}

sub save {
	my ($self, $instance) = (shift, shift);

	die "delete not implemented by ${\(ref $self)}";
}

sub save_multi {
	my $self = shift;

	$self->save($_) for @_;

	return;
}

1;
