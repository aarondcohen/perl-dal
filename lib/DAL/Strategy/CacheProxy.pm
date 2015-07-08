package DAL::Strategy::CacheProxy;

use parent 'DAL::Strategy';

sub load         { (shift)->cache_layer->load(shift) }
sub load_multi   { (shift)->cache_layer->load_multi(@_) }
sub delete       { (shift)->cache_layer->delete(shift) }
sub delete_multi { (shift)->cache_layer->delete_multi(@_) }
sub save         { (shift)->cache_layer->save(shift) }
sub save_multi   { (shift)->cache_layer->save_multi(@_) }

1;
