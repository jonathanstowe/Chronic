#!perl6

use v6;
use lib 'lib';

use Test;

use Chronic;

my @tests = (
    {
        chronic => {
            minute  => any(10,23),
        },
        dt  =>  {
            minute  => 23,
        },
        result  =>  True,
        description => "minutes",
    },
    {
        chronic => {
            hour  => any(10,23),
        },
        dt  =>  {
            hour  => 23,
        },
        result  =>  True,
        description => "hour",
    },
    {
        chronic => {
            hour  => any(10,23),
        },
        dt  =>  {
            hour  => 20,
        },
        result  =>  False,
        description => "hour negative",
    },
    {
        chronic => {
            day  => any(10,23),
            month   => any(12),
        },
        dt  =>  {
            day  => 23,
            month => 12,
        },
        result  =>  True,
        description => "Day and month",
    },
    {
        chronic => {
            day  => any(10,23),
            month   => any(12),
        },
        dt  =>  {
            day  => 23,
            month => 11,
        },
        result  =>  False,
        description => "Day and month (negative)",
    },
    {
        chronic => {
            minute  => any(15),
            month   => any(12),
        },
        dt  =>  {
            day  => 23,
            month => 11,
        },
        result  =>  False,
        description => "Minute and month (negative)",
    },
    {
        chronic => {
            minute  => any(15),
            month   => any(12),
        },
        dt  =>  {
            minute  => 15,
            month => 12,
        },
        result  =>  True,
        description => "Minute and month",
    },
);

ok DateTime.now ~~ Chronic::Description.new, "default comparison works";
ok Chronic::Description.new ~~ DateTime.now, "default comparison works (the other way round";

for @tests -> $test {
    $test<dt><year> = (1971 .. 2037).pick;
    if $test<result> {
        ok Chronic::Description.new(|$test<chronic>) ~~ DateTime.new(|$test<dt>), $test<description>;
    }
    else {
        nok Chronic::Description.new(|$test<chronic>) ~~ DateTime.new(|$test<dt>), $test<description>;

    }
}

done-testing;
# vim: expandtab shiftwidth=4 ft=perl6
