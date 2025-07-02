{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [

    netdiscover
    # Netdiscover is an active/passive address reconnaissance tool, 
    # mainly developed for those wireless networks without dhcp 
    # server, when you are wardriving. It can be also used on 
    # hub/switched networks. 
    # Built on top of libnet and libpcap, it can passively detect 
    # online hosts, or search for them, by actively sending ARP 
    # requests. 
    # Netdiscover can also be used to inspect your network ARP 
    # traffic, or find network addresses using auto scan mode, which 
    # will scan for common local networks. 
    # Netdiscover uses the OUI table to show the vendor of the each 
    # MAC address discovered and is very useful for security checks or 
    # in pentests. 

    # [Port-Scanner]
    nmap # unicornscan

    arping
    # The arping utility sends ARP and/or ICMP requests to the 
    # specified host and displays the replies. The host may be 
    # specified by its hostname, its IP address, or its MAC address. 

    hping
    # hping3 is a network tool able to send custom ICMP/UDP/TCP 
    # packets and to display target replies like ping does with ICMP 
    # replies. It handles fragmentation and arbitrary packet body and 
    # size, and can be used to transfer files under supported 
    # protocols. Using hping3, you can test firewall rules, perform 
    # (spoofed) port scanning, test network performance using 
    # different protocols, do path MTU discovery, perform 
    # traceroute-like actions under different protocols, fingerprint 
    # remote operating systems, audit TCP/IP stacks, etc. hping3 is 
    # scriptable using the Tcl language. 

    fping
    # fping is a ping like program which uses the Internet Control
    # Message Protocol (ICMP) echo request to determine if a target
    # host is responding. fping differs from ping in that you can
    # specify any number of targets on the command line, or specify a
    # file containing the lists of targets to ping. Instead of sending
    # to one target until it times out or replies, fping will send out
    # a ping packet and move on to the next target in a round-robin
    # fashion. 

    masscan
    # MASSCAN is TCP port scanner which transmits SYN packets 
    # asynchronously and produces results similar to nmap, the most 
    # famous port scanner. Internally, it operates more like scanrand, 
    # unicornscan, and ZMap, using asynchronous transmission. It’s a 
    # flexible utility that allows arbitrary address and port ranges. 

    # [DNS]
    dig dogdns dnsenum dnsmap dnsrecon dnstracer fierce # dqy sublist3r
    subfinder
    # This package contains a subdomain discovery tool that discovers 
    # valid subdomains for websites by using passive online sources. 
    # It has a simple modular architecture and is optimized for speed. 
    # subfinder is built for doing one thing only - passive subdomain 
    # enumeration, and it does that very well. 

    ######## maltego ######## [unfree]
    # Maltego is an open source intelligence and forensics 
    # application. It will offer you timous mining and gathering of 
    # information as well as the representation of this information in 
    # a easy to understand format. 
    # This package replaces previous packages matlegoce and casefile.

    ######## wpscan ######## [unfree]
    # WPScan scans remote WordPress installations to find security 
    # issues. 

    ######## spiderfoot ######## [not found]
    # This package contains an open source intelligence (OSINT)
    # automation tool. Its goal is to automate the process of
    # gathering intelligence about a given target, which may be an IP
    # address, domain name, hostname, network subnet, ASN, e-mail
    # address or person’s name. 
    # SpiderFoot can be used offensively, i.e. as part of a black-box
    # penetration test to gather information about the target, or
    # defensively to identify what information you or your
    # organisation are freely providing for attackers to use against
    # you. 

    ######## legion ######## [not found]
    # This package contains an open source, easy-to-use, 
    # super-extensible and semi-automated network penetration testing 
    # tool that aids in discovery, reconnaissance and exploitation of 
    # information systems. Legion is a fork of SECFORCE’s Sparta.
    
    whois
    # This package provides a commandline client for the WHOIS (RFC
    # 3912) protocol, which queries online servers for information
    # such as contact details for domains and IP address assignments.
    # It can intelligently select the appropriate WHOIS server for
    # most queries. 

    whatweb
    # WhatWeb identifies websites. It recognises web technologies
    # including content management systems (CMS), blogging platforms,
    # statistic/analytics packages, JavaScript libraries, web servers,
    # and embedded devices.
    # WhatWeb has over 900 plugins, each to recognise something
    # different. It also identifies version numbers, email addresses,
    # account IDs, web framework modules, SQL errors, and more.

    recon-ng
    # Recon-ng is a full-featured Web Reconnaissance framework written 
    # in Python. Complete with independent modules, database 
    # interaction, built in convenience functions, interactive help, 
    # and command completion, Recon-ng provides a powerful environment 
    # in which open source web-based reconnaissance can be conducted 
    # quickly and thoroughly. 
    # Recon-ng has a look and feel similar to the Metasploit 
    # Framework, reducing the learning curve for leveraging the 
    # framework. However, it is quite different. Recon-ng is not 
    # intended to compete with existing frameworks, as it is designed 
    # exclusively for web-based open source reconnaissance. If you 
    # want to exploit, use the Metasploit Framework. If you want to 
    # Social Engineer, use the Social Engineer Toolkit. 

    lbd
    # Checks if a given domain uses load-balancing.

    amass
    # This package contains a tool to help information security 
    # professionals perform network mapping of attack surfaces and 
    # perform external asset discovery using open source information 
    # gathering and active reconnaissance techniques. 
    # Information Gathering Techniques Used: - DNS: Basic enumeration, 
    # Brute forcing (upon request), Reverse DNS sweeping, Subdomain 
    # name alterations/permutations, Zone transfers (upon request) - 
    # Scraping: Ask, Baidu, Bing, DNSDumpster, DNSTable, Dogpile, 
    # Exalead, Google, HackerOne, IPv4Info, Netcraft, PTRArchive, 
    # Riddler, SiteDossier, ViewDNS, Yahoo - Certificates: Active 
    # pulls (upon request), Censys, CertSpotter, Crtsh, Entrust, 
    # GoogleCT - APIs: AlienVault, BinaryEdge, BufferOver, CIRCL, 
    # CommonCrawl, DNSDB, HackerTarget, Mnemonic, NetworksDB, 
    # PassiveTotal, RADb, Robtex, SecurityTrails, ShadowServer, 
    # Shodan, Spyse (CertDB & FindSubdomains), Sublist3rAPI, 
    # TeamCymru, ThreatCrowd, Twitter, Umbrella, URLScan, VirusTotal - 
    # Web Archives: ArchiveIt, ArchiveToday, Arquivo, LoCArchive, 
    # OpenUKArchive, UKGovArchive, Wayback 

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

    # [Web-Directory-Enumerator]
    wfuzz
    # Wfuzz is a tool designed for bruteforcing Web Applications, it
    # can be used for finding resources not linked directories,
    # servlets, scripts, etc, bruteforce GET and POST parameters for
    # checking different kind of injections (SQL, XSS, LDAP,etc),
    # bruteforce Forms parameters (User/Password), Fuzzing, etc. 

    gobuster
    # Gobuster is useful for pentesters, ethical hackers and forensics
    # experts. It also can be used for security tests.Gobuster is a
    # tool used to brute-force: URIs (directories and files) in web
    # sites, DNS subdomains (with wildcard support), Virtual Host
    # names on target web servers, Open Amazon S3 buckets, Open Google
    # Cloud buckets and TFTP servers.
    # Gobuster is useful for pentesters, ethical hackers and forensics
    # experts. It also can be used for security tests.

    dirb
    # DIRB is a Web Content Scanner. It looks for existing (and/or
    # hidden) Web Objects. It basically works by launching a
    # dictionary based attack against a web server and analyzing the
    # responses.
    # DIRB comes with a set of preconfigured attack wordlists for easy
    # usage but you can use your custom wordlists. Also DIRB sometimes
    # can be used as a classic CGI scanner, but remember that it is a
    # content scanner not a vulnerability scanner.
    # DIRB’s main purpose is to help in professional web application
    # auditing. Specially in security related testing. It covers some
    # holes not covered by classic web vulnerability scanners. DIRB
    # looks for specific web objects that other generic CGI scanners
    # can’t look for. It doesn’t search vulnerabilities nor does
    # it look for web contents that can be vulnerable.

    ffuf
    # ffuf is a fast web fuzzer written in Go that allows typical
    # directory discovery, virtual host discovery (without DNS
    # records) and GET and POST parameter fuzzing. 
    # This program is useful for pentesters, ethical hackers and
    # forensics experts. It also can be used for security tests. 

    dirbuster
    # DirBuster is a multi threaded java application designed to brute 
    # force directories and files names on web/application servers. 
    # Often is the case now of what looks like a web server in a state 
    # of default installation is actually not, and has pages and 
    # applications hidden within. DirBuster attempts to find these. 
    # However tools of this nature are often as only good as the 
    # directory and file list they come with. A different approach was 
    # taken to generating this. The list was generated from scratch, 
    # by crawling the Internet and collecting the directory and files 
    # that are actually used by developers! DirBuster comes a total of 
    # 9 different lists, this makes DirBuster extremely effective at 
    # finding those hidden files and directories. And if that was not 
    # enough DirBuster also has the option to perform a pure brute 
    # force, which leaves the hidden directories and files nowhere to 
    # hide. 

    scout
    # Lightweight URL fuzzer and spider: Discover a web server's
    # undisclosed files, directories and VHOSTs 
  ];
}
