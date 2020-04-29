This repo contains
ipset restore files
and a set of bash commands
that load, flush and restore ipsets.

This ipset config works with
the iptables rules and systemd services
in [stack-deploy](https://github.com/tessercat/stack-deploy)
and with the [firewall-api](https://github.com/tessercat/firewall-api)
Django project
to provide a simple Linux firewall.

Run the bash commands
before loading iptables rules.

Place lists of addresses
in the `lists` directory,
one address per line,
in files named
`block4`, `block6`,
`admin4` and `admin6`,
and run the bash commands
to init, flush and load the sets.

    bash commands.bash

The restore files in `sets`
create ipsets in `hash:ip` format,
so lists can contain single addresses
and subnets in CIDR format.
