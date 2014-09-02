#!/usr/bin/env perl

use 5.010;
use Moose;
use Test::More;

use lib 't/lib';
use Test::Import::Products;
use Test::Schema;

my $schema = Test::Schema->connect('dbi:SQLite:t/test.db');

ok(my $import = Test::Import::Products->new(
	schema => $schema,
	file_name => 't/test.csv',
), 'New csv file');

ok($import->do_work, 'Import csv file');

ok($import = Test::Import::Products->new(
	schema => $schema,
	file_name => 't/test.ods',
), 'New ods file');

ok($import->do_work, 'Import ods file');

ok($import = Test::Import::Products->new(
	schema => $schema,
	file_name => 't/test.xls',
), 'New xls file');

ok($import->do_work, 'Import xls file');

done_testing();

