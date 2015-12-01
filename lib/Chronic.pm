use v6;

class Chronic {
    class Description {

        my Range $minute-range = 0 .. 59;
        multi sub get-minutes(Whatever $) {
            get-minutes($minute-range);
        }
        multi sub get-minutes(Range $r where {all($_.list) ~~ $minute-range}) {
            get-minutes($r.list);
        }
        multi sub get-minutes(*@m where { all($_) ~~ $minute-range }) {
            get-minutes(@m);
        }
        multi sub get-minutes(@m where { all($_) ~~ $minute-range }) {
            any(@m);
        }
        has Junction $.minute       is rw = get-minutes(*);

        my Range $hour-range = 0 .. 23;
        multi sub get-hours(Whatever $) {
            get-hours($hour-range);
        }
        multi sub get-hours(Range $r where {all($_.list) ~~ $hour-range}) {
            get-hours($r.list);
        }
        multi sub get-hours(*@m where { all($_) ~~ $hour-range }) {
            get-hours(@m);
        }
        multi sub get-hours(@m where { all($_) ~~ $hour-range }) {
            any(@m);
        }
        has Junction $.hour         is rw = get-hours(*);

        my Range $day-range = 1 .. 31;
        multi sub get-days(Whatever $) {
            get-days($day-range);
        }
        multi sub get-days(Range $r where {all($_.list) ~~ $day-range}) {
            get-days($r.list);
        }
        multi sub get-days(*@m where { all($_) ~~ $day-range }) {
            get-days(@m);
        }
        multi sub get-days(@m where { all($_) ~~ $day-range }) {
            any(@m);
        }
        has Junction $.day          is rw = get-days(*);

        my Range $month-range = 1 .. 12;
        multi sub get-months(Whatever $) {
            get-months($month-range);
        }
        multi sub get-months(Range $r where {all($_.list) ~~ $month-range}) {
            get-months($r.list);
        }
        multi sub get-months(*@m where { all($_) ~~ $month-range }) {
            get-months(@m);
        }
        multi sub get-months(@m where { all($_) ~~ $month-range }) {
            any(@m);
        }
        has Junction $.month        is rw = get-months(*);

        my Range $dow-range = 1 .. 7;
        multi sub get-dows(Whatever $) {
            get-dows($dow-range);
        }
        multi sub get-dows(Range $r where {all($_.list) ~~ $dow-range}) {
            get-dows($r.list);
        }
        multi sub get-dows(*@m where { all($_) ~~ $dow-range }) {
            get-dows(@m);
        }
        multi sub get-dows(@m where { all($_) ~~ $dow-range }) {
            any(@m);
        }
        has Junction $.day-of-week  is rw = get-dows(*);

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
