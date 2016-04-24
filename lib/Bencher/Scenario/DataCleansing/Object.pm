package Bencher::Scenario::DataCleansing::Object;

# DATE
# VERSION

use 5.010001;
use strict;
use warnings;

our $scenario = {
    summary => 'Benchmark data cleansing (unblessing object)',
    modules => {
        # for the Data::Rmap method
        'Acme::Damn' => {},
        'Scalar::Util' => {},
    },
    participants => [
        {
            name => 'Data::Clean-inplace',
            module => 'Data::Clean',
            code_template => 'state $cl = Data::Clean->new(-obj => ["unbless"]); $cl->clean_in_place(<data>)',
            tags => ['inplace'],
        },
        {
            name => 'Data::Clean-clone',
            module => 'Data::Clean',
            code_template => 'state $cl = Data::Clean->new(-obj => ["unbless"]); $cl->clone_and_clean(<data>)',
        },
        {
            name => 'JSON::PP',
            module => 'JSON::PP',
            code_template => 'state $json = JSON::PP->new->allow_blessed(1)->convert_blessed(1); $json->decode($json->encode(<data>))',
        },
        {
            name => 'Data::Rmap',
            module => 'Data::Rmap',
            code_template => 'my $data = <data>; Data::Rmap::rmap_ref(sub { Acme::Damn::damn($_) if Scalar::Util::blessed($_) }, $data); $data',
            tags => ['inplace'],
        },
    ],
    datasets => [
        {
            name => 'ary100-u1-obj',
            summary => 'A 100-element array containing 1 "unclean" data: object',
            args => {
                data => do {
                    my $data = [0..99];
                    $data->[49] = bless [], "Foo";
                    $data;
                },
            },
        },
        {
            name => 'ary100-u100-obj',
            summary => 'A 100-element array containing 100 "unclean" data: object',
            args => {
                data => do {
                    my $data = [map {bless [], "Foo"} 0..99];
                    $data;
                },
            },
        },
        {
            name => 'ary10k-u1-obj',
            summary => 'A 10k-element array containing 1 "unclean" data: object',
            args => {
                data => do {
                    my $data = [0..999];
                    $data->[499] = bless [], "Foo";
                    $data;
                },
            },
        },
        {
            name => 'ary10k-u10k-obj',
            summary => 'A 10k-element array containing 10k "unclean" data: object',
            args => {
                data => do {
                    my $data = [map {bless [], "Foo"} 0..999];
                    $data;
                },
            },
        },
    ],
};

1;
# ABSTRACT:

=head1 SEE ALSO
