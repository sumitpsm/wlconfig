{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    whois
    # spiderfoot
    
    dmitry
    # Run a domain whois lookup (w), an IP whois lookup (i), retrieve 
    # Netcraft info (n), search for subdomains (s), search for email 
    # addresses (e), do a TCP port scan (p), and save the output to 
    # example.txt (o) for the domain example.com 

    theharvester
    # The package contains a tool for gathering subdomain names, 
    # e-mail addresses, virtual hosts, open ports/ banners, and 
    # employee names from different public sources (search engines, 
    # pgp key servers). 
  ];
}
