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

	die "to_identifier not implemented by ${\(ref $self)}";
}

sub to_identifiers {
	my $self = shift;

	return map { $self->to_identifier($_) } @_;
}

sub clean {}
sub validate {}

##############################
# Accesors
##############################

sub load {
	my ($self, $identifier) = (shift, shift);

	my $instance = $self->_load($identifier);
	$self->clean($instance) if $instance;

	return $instance;
}

sub load_multi {
	my $self = shift;

	my @instances = $self->_load_multi(@_);
	$self->clean($_) for grep { $_ } @instances;

	return @instances;
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

	$self->_delete($instance);
	$self->clean($instance);

	return;
}

sub delete_multi {
	my $self = shift;

	$self->_delete_multi(@_);
	$self->clean($_) for @_;

	return;
}

sub save {
	my ($self, $instance) = (shift, shift);

	$self->validate($instance);
	$self->_save($instance);
	$self->clean($instance);

	return;
}

sub save_multi {
	my $self = shift;

	$self->validate($_) for @_;
	$self->_save_multi(@_);
	$self->clean($_) for @_;

	return;
}

##############################
# Implementation
##############################

sub _delete {
	my ($self, $instance) = (shift, shift);

	die "_delete not implemented by ${\(ref $self)}";
}

sub _delete_multi {
	my $self = shift;

	$self->_delete($_) for @_;

	return;
}

sub _load {
	my ($self, $identifier) = (shift, shift);

	die "_load not implemented by ${\(ref $self)}";
}

sub _load_multi {
	my $self = shift;

	return map { $self->_load($_) } @_;
}

sub _save {
	my ($self, $instance) = (shift, shift);

	die "_save not implemented by ${\(ref $self)}";
}

sub _save_multi {
	my $self = shift;

	$self->_save($_) for @_;

	return;
}

1;
