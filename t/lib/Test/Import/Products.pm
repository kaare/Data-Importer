package Test::Import::Products;

use 5.010;
use namespace::autoclean;
use Moose;
use MooseX::Traits;

extends 'Data::Importer';

=head1 ATTRIBUTES

=head2 products

An arrayref w/ the products to be inserted / updated

=cut

has 'products' => (
	is => 'ro',
	isa => 'ArrayRef',
	traits => [qw/Array/],
	handles => {
		add_product => 'push',
	},
	default => sub { [] },
);

=head1 METHODS

=head2 handle_row

Validates input

Called for each row in the input file

=cut

sub handle_row {
	my ($self, $row, $lineno) = @_;
	#product
	my %prow = ( %$row );
	$self->add_product(\%prow);
}

=head2 import_transaction

Performs the actual database update

=cut

sub import_transaction {
	my $self = shift;
	my $schema = $self->schema;
	for my $product (@{ $self->products }) {
		next unless $product->{item_name};

		my $data = {
			name => $product->{item_name},
			ingredients => $product->{ingredients},
			qty => $product->{qty},
		};
		$schema->resultset('Product')->create($data) or die;
	}
}

__PACKAGE__->meta->make_immutable;

# COPYRIGHT

__END__
