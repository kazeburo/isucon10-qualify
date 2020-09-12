#! /usr/bin/env perl

use strict;
use warnings;

use JSON;
use Data::Dumper;

my $json = JSON->new;

my $estate_condition = load_json('../../fixture/estate_condition.json');
my $chair_condition = load_json('../../fixture/chair_condition.json');

generate_sql('isuumo.estate_feature', 'estate_id',
             'dump_estate_id_features.csv',
             $estate_condition->{feature}{list},
             '3_DummyEstateFeatureData.sql'
         );
generate_sql('isuumo.chair_feature', 'chair_id',
             'dump_chair_id_features.csv',
             $chair_condition->{feature}{list},
             '4_DummyChairFeatureData.sql'
         );

sub load_json {
    my $json_file = shift;

    local $/ = undef;
    open(my $fh, $json_file) || die "Cant open $json_file : $!";
    return JSON->new->decode(<$fh>);
}

sub generate_sql {
    my $table_name = shift;
    my $id_column_name = shift;
    my $csv_file = shift;
    my $feature_list = shift;
    my $output_file = shift;

    my $feature_to_id = {};
    for(my $id = 0;$id < @$feature_list;$id ++) {
        $feature_to_id->{$feature_list->[$id]} = $id;
    }

    open(my $out_fh, "> $output_file") or die "Cant open $output_file:$!";
    print $out_fh <<"END;";
INSERT INTO $table_name (id, $id_column_name) VALUES
END;
    my $is_first = 1;

    open(my $fh, $csv_file) || die "Cant open $csv_file : $!";
    while(my $line = <$fh>){
        chomp($line);

        my($id, $features) = split(/\s+/, $line);
        foreach my $feature (split(/\s*,\s*/, $features)) {
            print $out_fh ',' unless $is_first;
            $is_first = 0;
            print $out_fh "\n";

            my $feature_id = $feature_to_id->{$feature};
            print $out_fh "($id, $feature_id)";
        }
    }
    print $out_fh <<"END;";
;
END;
    close($fh);
    close($out_fh);
}
