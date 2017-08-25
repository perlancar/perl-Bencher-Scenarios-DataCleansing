package Bencher::Scenario::DataCleansing::Startup;

# DATE
# VERSION

use 5.010001;
use strict;
use warnings;

our $scenario = {
    summary => 'Benchmark startup of various data cleansing modules',
    module_startup => 1,
    modules => {
        # specify minimum version
        'Data::Clean::JSON' => {version=>'0.38'},
    },
    participants => [
        {module=>'Data::Clean'},
        {module=>'Data::Clean::JSON'},

        {module=>'JSON::MaybeXS'},
        {module=>'JSON::PP'},
        {module=>'JSON::XS'},
        {module=>'Cpanel::JSON::XS'},

        {module=>'Data::Rmap'},
        {module=>'Data::Abridge'},
        {module=>'Data::Visitor::Callback'},
        {module=>'Data::Tersify'},
    ],
};

1;
# ABSTRACT:

=head1 SEE ALSO
