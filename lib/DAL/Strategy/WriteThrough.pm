package DAL::Strategy::WriteThrough;

use parent 'DAL::Strategy';

use Set::Functional ();

sub _load {
	my ($self, $identifier) = (shift, shift);

	my $instance = $self->cache_layer->_load($identifier);

	unless ($instance) {
		$instance = $self->storage_layer->_load($identifier);
		$self->cache_layer->_save($instance);
	}

	return $instance;
}

sub _load_multi {
	my $self = shift;

	my @cached_instances = $self->cache_layer->_load_multi(@_);
	my @uncached_identifers = Set::Functional::difference_by
		{ $self->identifier_to_string($_) }
		\@_,
		[$self->to_identifiers(@cached_instances)];

	my @stored_instances;
	if (@uncached_identifiers) {
		@stored_instances = $self->storage_layer->_load_multi(@uncached_identifers);
		$self->cache_layer->_save_multi(@stored_instances);
	}

	return (@cached_instances, @stored_instances);
}

sub _delete {
	my ($self, $instance) = (shift, shift);

	$self->storage_layer->_delete($instance);
	$self->cache_layer->_delete($instance);

	return;
}

sub _delete_multi {
	my $self = shift;

	$self->storage_layer->_delete_multi(@_);
	$self->cache_layer->_delete_multi(@_);

	return;
}

sub _save {
	my ($self, $instance) = (shift, shift);

	$self->storage_layer->_save($instance);
	$self->cache_layer->_save($instance);

	return;
}

sub _save_multi {
	my $self = shift;

	$self->storage_layer->_save_multi(@_);
	$self->cache_layer->_save_multi(@_);

	return;
}

1;
