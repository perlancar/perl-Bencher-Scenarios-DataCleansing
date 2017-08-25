package Bencher::Scenario::DataCleansing::Object_DateTime;

# DATE
# VERSION

use 5.010001;
use strict;
use warnings;

use DateTime;

sub _dt { DateTime->from_epoch(epoch => 1503646935) }

our $scenario = {
    summary => 'Benchmark data cleansing (DateTime objects into scalar)',
    modules => {
        # for the Data::Rmap method
        'Acme::Damn' => {},
        'Scalar::Util' => {},
        # specify minimum version
        'Data::Clean' => {version=>'0.48'},
    },

    participants => [
        {
            name => 'Data::Clean-inplace',
            module => 'Data::Clean',
            code_template => 'state $cl = Data::Clean->new(DateTime => ["stringify"]); $cl->clean_in_place(<data>)',
            tags => ['inplace'],
        },
        {
            name => 'Data::Clean-clone',
            module => 'Data::Clean',
            code_template => 'state $cl = Data::Clean->new(DateTime => ["stringify"]); $cl->clone_and_clean(<data>)',
        },
        {
            name => 'Data::Rmap',
            module => 'Data::Rmap',
            code_template => 'my $data = <data>; Data::Rmap::rmap_ref(sub { if (ref $_ eq "DateTime") { "$_" } else { $_ } }, $data); $data',
            tags => ['inplace'],
        },
        {
            name => 'Data::Tersify',
            module => 'Data::Tersify',
            helper_modules => ['Data::Tersify::Plugin::DateTime'],
            code_template => 'Data::Tersify::tersify(<data>)',
        },
    ],

    datasets => [
        {
            name => 'ary1-dt1',
            summary => 'A 1-element array containing 1 DateTime object',
            args => {
                data => [_dt()],
            },
        },
        {
            name => 'ary10-dt10',
            summary => 'A 10-element array containing 10 DateTime objects',
            args => {
                data => [map {_dt()} 1..10],
            },
        },
        {
            name => 'ary100-dt100',
            summary => 'A 100-element array containing 100 DateTime objects',
            args => {
                data => [map {_dt()} 1..100],
            },
        },
        {
            name => 'ary1000-dt1000',
            summary => 'A 1000-element array containing 1000 DateTime objects',
            args => {
                data => [map {_dt()} 1..1000],
            },
        },
        {
            name => 'ary1000-dt1',
            summary => 'A 1000-element array containing 1 DateTime objects',
            args => {
                data => [(map {$_} 1..999), _dt()],
            },
        },
    ],
};

1;
# ABSTRACT:

=head1 SEE ALSO
