# rancher-varnish
Varnish using monit and confd based on [rawmind0/alpine-traefik](https://github.com/rawmind0/alpine-traefik).

Developed to be used with [ipunks/docker-varnish-stale-config](https://github.com/ipunkt/docker-varnish-stale-config)

# Ports
- 8080: varnish cache
- 6082: varnish admin tool. Currently bound to 127.0.0.1 so exposing this will not work

# Options
All options must be set as environment variable
- VARNISH_CONFIG: The path to the varnish config file. Use supply one via volumes_from or 
  create one using rancher-tools confd 
  defaults to `/opt/varnish/etc/default.vcl`  
  Alternative: `/opt/varnish/etc/no-bots.vcl` - switches to pass-through mode for bot crawler
- SECRET_FILE: The path to the secret file to use as pre-shared key for the admin interface  
  defaults to `/opt/varnish/etc/secret`
- BIND_ADDRESS:   
  defaults to 0.0.0.0
- PORT: Override which port varnish should listen on. Note that varnish does not
  run with root privileges so ports <= 1024 will not work.  
  defaults to 8080
  
See [rancher-tools](https://github.com/rawmind0/rancher-tools) for more options.  
We especially use `CONF_INTERVAL=2` when handling ip addresses so rolling-upgrades and changing links work without delay
