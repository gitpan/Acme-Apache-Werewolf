package Acme::Apache::Werewolf;
use strict;
use Astro::MoonPhase;
use Apache::Constants qw(:common);

use vars qw($VERSION);
$VERSION = '1.03';

sub handler {
    my $r = shift;
    my $moonlength = $r->dir_config('MoonLength');
    warn "Moon length is $moonlength";

    my ( $MoonPhase,
          $MoonIllum,
          $MoonAge,
          $MoonDist,
          $MoonAng,
          $SunDist,
          $SunAng ) = phase(time);

    return FORBIDDEN unless abs(14 - $MoonAge) > ($moonlength/2);
    return OK;
}

=head1 NAME

Acme::Apache::Werewolf

=head1 SYNOPSIS

    <Directory /fullmoon>
        PerlAccessHandler Acme::Apache::Werewolf
        PerlSetVar MoonLength 4
    </Directory>

=head1 DESCRIPTION

This mod_perl handler performs the important function of keeping people
out of a directory during the full moon.

=head1 USAGE

In your configuration file, put the following configuration

    <Directory /fullmoon>
        PerlAccessHandler Acme::Apache::Werewolf
        PerlSetVar MoonLength 4
    </directory>

The MoonLength variable indicates how long a period you want to consider
to be the full moon. In the above configuration, the full moon is 4
days, which would be from day 12 through day 16 of the lunar cycle. It
is wise to err on the side of caution and make this too large, rather
than make it too small, and risk the wrath of werewolves.

=head1 AUTHOR

    Rich Bowen
	rbowen@rcbowen.com
	http://rcbowen.com/

=head1 COPYRIGHT

This program is free software; you can redistribute
it and/or modify it under the same terms as Perl itself.

The full text of the license can be found in the
LICENSE file included with this module.

=head1 SEE ALSO

Astro::MoonPhase

=cut

1; 

