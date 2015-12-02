use v6;

class Chronic {
    class Description {

        sub expand-expression(Str $exp, Range $r) returns Array[Int] {
            my Int @values;

            my ($top, $divisor) = $exp.split('/');

            sub explode-item(Str $v) {
	            if $v.contains('-') {
		            my ( $min, $max ) = $v.split('-');
		            my Range $r = $min.Int .. $max.Int;
		            $r.list;
	            }
	            else {
		            $v;
                }
            }

            if $top eq '*' {
                @values = $r.list;
            }
            else {
                @values = $top.split(',').flatmap(&explode-item).map(*.Int);
            }

            if $divisor.defined {
                @values = @values.grep( * %% $divisor.Int);
            }

            @values;
        }

        my Range $minute-range = 0 .. 59;
        multi sub get-minutes(Whatever $) {
            get-minutes($minute-range);
        }
        multi sub get-minutes('*') {
            get-minutes(*);
        }
        multi sub get-minutes(Str $exp) {
            my Int @m = expand-expression($exp, $minute-range);
            get-minutes(@m);
        }
        multi sub get-minutes(Range $r where {all($_.list) ~~ $minute-range}) {
            my Int @m = $r.list;
            get-minutes(@m);
        }
        multi sub get-minutes(*@m where { all($_.list) ~~ $minute-range }) {
            get-minutes(@m);
        }
        multi sub get-minutes(@m where { all($_.list) ~~ $minute-range }) {
            any(@m);
        }
        has Junction $.minute       is rw = get-minutes(*);

        my Range $hour-range = 0 .. 23;
        multi sub get-hours(Whatever $) {
            get-hours($hour-range);
        }
        multi sub get-hours('*') {
            get-hours(*);
        }
        multi sub get-hours(Str $exp) {
            my Int @m = expand-expression($exp, $hour-range);
            get-hours(@m);
        }
        multi sub get-hours(Range $r where {all($_.list) ~~ $hour-range}) {
            my Int @m = $r.list;
            get-hours(@m);
        }
        multi sub get-hours(*@m where { all($_.list) ~~ $hour-range }) {
            get-hours(@m);
        }
        multi sub get-hours(@m where { all($_.list) ~~ $hour-range }) {
            any(@m);
        }
        has Junction $.hour         is rw = get-hours(*);

        my Range $day-range = 1 .. 31;
        multi sub get-days(Whatever $) {
            get-days($day-range);
        }
        multi sub get-days('*') {
            get-days(*);
        }
        multi sub get-days(Str $exp) {
            my Int @m = expand-expression($exp, $day-range);
            get-days(@m);
        }
        multi sub get-days(Range $r where {all($_.list) ~~ $day-range}) {
            my Int @m = $r.list;
            get-days(@m);
        }
        multi sub get-days(*@m  where { all($_.list) ~~ $day-range }) {
            get-days(@m);
        }
        multi sub get-days(@m where { all($_.list) ~~ $day-range }) {
            any(@m);
        }
        has Junction $.day          is rw = get-days(*);

        my Range $month-range = 1 .. 12;
        multi sub get-months(Whatever $) {
            get-months($month-range);
        }
        multi sub get-months('*') {
            get-months(*);
        }
        multi sub get-months(Str $exp) {
            my Int @m = expand-expression($exp, $month-range);
            get-months(@m);
        }
        multi sub get-months(Range $r where { all($_.list) ~~ $month-range }) {
            my Int @m = $r.list;
            get-months(@m);
        }
        multi sub get-months(*@m where { all($_.list) ~~ $month-range }) {
            get-months(@m);
        }
        multi sub get-months(@m where { all($_.list) ~~ $month-range }) {
            any(@m);
        }
        has Junction $.month        is rw = get-months(*);

        my Range $dow-range = 1 .. 7;
        multi sub get-dows(Whatever $) {
            get-dows($dow-range);
        }
        multi sub get-dows('*') {
            get-dows(*);
        }
        multi sub get-dows(Str $exp) {
            my Int @m = expand-expression($exp, $dow-range);
            get-dows(@m);
        }
        multi sub get-dows(Range $r where {all($_.list) ~~ $dow-range}) {
            my Int @m = $r.list;
            get-dows($r.list);
        }
        multi sub get-dows(*@m where { all($_.list) ~~ $dow-range }) {
            get-dows(@m);
        }
        multi sub get-dows(@m where { all($_.list) ~~ $dow-range }) {
            any(@m);
        }
        has Junction $.day-of-week  is rw = get-dows(*);


        my %params = (
            minute      =>  &get-minutes,
            hour        =>  &get-hours,
            day         =>  &get-days,
            month       =>  &get-months,
            day-of-week =>  &get-dows
        );

        multi method new(*%args) {
            my %new-args;

            for %args.kv -> $k, $v {
                if %params{$k}:exists {
                    %new-args{$k} = do if $v ~~ Junction {
                        $v;
                    }
                    else {
                        %params{$k}($v);
                    }
                }
            }
            self.bless(|%new-args);
        }

        multi method ACCEPTS(DateTime $d) returns Bool {
            $d.minute       ~~ $!minute &&
            $d.hour         ~~ $!hour   &&
            $d.day          ~~ $!day    &&
            $d.month        ~~ $!month  &&
            $d.day-of-week  ~~ $!day-of-week;
        }
    }

}

use MONKEY-TYPING;

augment class DateTime {
    multi method ACCEPTS(Chronic::Description $d) returns Bool {
        self.minute       ~~ $d.minute &&
        self.hour         ~~ $d.hour   &&
        self.day          ~~ $d.day    &&
        self.month        ~~ $d.month  &&
        self.day-of-week  ~~ $d.day-of-week;
    }
    
}

# vim: ft=perl6 expandtab sw=4
