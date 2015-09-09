package DAL::Strategy::WriteBehind;

use parent 'DAL::Strategy';

use Set::Functional ();

sub load {
	my ($self, $identifier) = (shift, shift);

	my $instance = $self->cache_layer->load($identifier);

	unless ($instance) {
		$instance = $self->storage_layer->load($identifier);
		$self->cache_layer->save($instance);
	}

	return $instance;
}

sub load_multi {
	my $self = shift;

	my @cached_instances = $self->cache_layer->load_multi(@_);
	my @uncached_identifers = Set::Functional::difference_by
		{ $self->identifier_to_string($_) }
		\@_,
		[$self->to_identifiers(@cached_instances)];

	my @stored_instances;
	if (@uncached_identifiers) {
		@stored_instances = $self->storage_layer->load_multi(@uncached_identifers);
		$self->cache_layer->save_multi(@stored_instances);
	}

	return (@cached_instances, @stored_instances);
}

sub delete {
	my ($self, $instance) = (shift, shift);

	$self->storage_layer->delete($instance);
	$self->cache_layer->delete($instance);

	return;
}

sub delete_multi {
	my $self = shift;

	$self->storage_layer->delete_multi(@_);
	$self->cache_layer->delete_multi(@_);

	return;
}

sub save {
	my ($self, $instance) = (shift, shift);

	$self->cache_layer->save($instance);
	#TODO: enqueue write to storage

	return;
}

sub save_multi {
	my $self = shift;

	$self->cache_layer->save_multi(@_);
	#TODO: enqueue writes to storage

	return
}

1;
