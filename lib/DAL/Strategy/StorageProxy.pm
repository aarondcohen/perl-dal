package DAL::Strategy::StorageProxy;

use parent 'DAL::Strategy';

sub load         { (shift)->storage_layer->load(shift) }
sub load_multi   { (shift)->storage_layer->load_multi(@_) }
sub delete       { (shift)->storage_layer->delete(shift) }
sub delete_multi { (shift)->storage_layer->delete_multi(@_) }
sub save         { (shift)->storage_layer->save(shift) }
sub save_multi   { (shift)->storage_layer->save_multi(@_) }

1;
