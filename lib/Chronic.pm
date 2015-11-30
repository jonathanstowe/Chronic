use v6;

class Chronic {
    class Description {
        has Junction $.minute       is rw = any(0..59);
        has Junction $.hour         is rw = any(0..23);
        has Junction $.day          is rw = any(1..31);
        has Junction $.month        is rw = any(1..12);
        has Junction $.day-of-week  is rw = any(1..7);

        multi method ACCEPTS(DateTime $d) returns Bool {
            $d.minute       ~~ $!minute &&
            $d.hour         ~~ $!hour   &&
            $d.day          ~~ $!day    &&
            $d.month        ~~ $!month  &&
            $d.day-of-week  ~~ $!day-of-week;
        }
    }

}
# vim: ft=perl6 expandtab sw=4
