package Test::Import::Products;

use 5.010;
use namespace::autoclean;
use Moose;
use MooseX::Traits;

extends 'Data::Importer';

=head1 METHODS

=head2 handle_row

Validates input

Called for each row in the input file

=cut

sub validate_row {
	my ($self, $row, $lineno) = @_;
	#product
	my %prow = ( %$row );
	$self->add_row(\%prow);
}

=head2 import_row

Performs the actual database update

=cut

sub import_row {
	my ($self, $row) = @_;
	return unless $row->{item_name};

	my $schema = $self->schema;

	my $data = {
		name => $row->{item_name},
		ingredients => $row->{ingredients},
		qty => $row->{qty},
	};
	$schema->resultset('Product')->create($data) or die;
}

__PACKAGE__->meta->make_immutable;

# COPYRIGHT

__END__
