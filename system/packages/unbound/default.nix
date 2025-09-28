{
  services.unbound = {
    enable = true;
    resolveLocalQueries = true;
    enableRootTrustAnchor = true;
    localControlSocketPath = "/run/unbound/unbound.ctl";
    settings = {
      server = {
        interface = [ "127.0.0.1@53" ];
        prefetch = true;
        cache-min-ttl = 3600;
      };

      forward-zone = {
        name = ".";
        forward-addr = [
          "9.9.9.9@853#dns.quad9.net"
          "1.1.1.1@853#cloudflare-dns.com"
          "94.140.14.14"
          "8.8.8.8"
        ];
        forward-first = false;
      };

      local-zone = [ ];
      local-data = [ ];
    };
  };
}
