package DAL::Strategy::ReadBehind;

use parent 'DAL::Strategy';

sub load {
	my ($self, $identifier) = (shift, shift);

	return $self->cache_layer->load($identifier);
}

sub load_multi {
	my $self = shift;

	return $self->cache_layer->load_multi(@_);
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

	$self->storage_layer->save($instance);
	#TODO: enqueue write to cache

	return;
}

sub save_multi {
	my $self = shift;

	$self->storage_layer->save_multi(@_);
	#TODO: enqueue writes to cache

	return
}

1;
