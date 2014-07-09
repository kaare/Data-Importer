package Test::Schema::Result::Product;
use base qw/DBIx::Class::Core/;
__PACKAGE__->table('product');
__PACKAGE__->add_columns(qw/ id name ingredients qty /);
__PACKAGE__->set_primary_key('id');

1;
