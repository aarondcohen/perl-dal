package DAL::Strategy::ReadBehind;

use parent 'DAL::Strategy';

sub _load {
	my ($self, $identifier) = (shift, shift);

	return $self->cache_layer->_load($identifier);
}

sub _load_multi {
	my $self = shift;

	return $self->cache_layer->_load_multi(@_);
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
	#TODO: enqueue write to cache

	return;
}

sub _save_multi {
	my $self = shift;

	$self->storage_layer->_save_multi(@_);
	#TODO: enqueue writes to cache

	return
}

1;
