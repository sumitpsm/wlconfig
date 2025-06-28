{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    nushell fish # powershell
    # coreutils, busybox, toybox, moreutils, iproute2, util-linux, procps, nettools, inetutils, sysstat
    arp-scan arp-scan-rs
    nmap # unicornscan

    # DNS
    dig dogdns dnsenum dnsmap dnsrecon dnstracer fierce # dqy

    thc-ipv6
    xh
    procs
    mtr
    lshw
    termshark
    lsof
    ipcalc
    # (vmstat, iostat, ifstat, netstat)
    # wormhole
    dhcpdump
    # impacket-scripts
    # netsniff-ng

    thc-hydra
    # Hydra is a parallelized login cracker which supports numerous 
    # protocols to attack. It is very fast and flexible, and new
    # modules are easy to add. This tool makes it possible for
    # researchers and security consultants to show how easy it would
    # be to gain unauthorized access to a system remotely.
    # It supports: Cisco AAA, Cisco auth, Cisco enable, CVS, FTP,
    # HTTP(S)-FORM-GET, HTTP(S)-FORM-POST, HTTP(S)-GET, HTTP(S)-HEAD,
    # HTTP-Proxy, ICQ, IMAP, IRC, LDAP, MS-SQL, MySQL, NNTP, Oracle
    # Listener, Oracle SID, PC-Anywhere, PC-NFS, POP3, PostgreSQL,
    # RDP, Rexec, Rlogin, Rsh, SIP, SMB(NT), SMTP, SMTP Enum, SNMP
    # v1+v2+v3, SOCKS5, SSH (v1 and v2), SSHKEY, Subversion,
    # Teamspeak (TS2), Telnet, VMware-Auth, VNC and XMPP.

    metasploit
    # The Metasploit Framework is an open source platform that
    # supports vulnerability research, exploit development, and the
    # creation of custom security tools.

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

    cowpatty
    # If you are auditing WPA-PSK or WPA2-PSK networks, you can use
    # this tool to identify weak passphrases that were used to
    # generate the PMK. Supply a libpcap capture file that includes
    # the 4-way handshake, a dictionary file of passphrases to guess
    # with, and the SSID for the network.

    whatweb
    # WhatWeb identifies websites. It recognises web technologies
    # including content management systems (CMS), blogging platforms,
    # statistic/analytics packages, JavaScript libraries, web servers,
    # and embedded devices.
    # WhatWeb has over 900 plugins, each to recognise something
    # different. It also identifies version numbers, email addresses,
    # account IDs, web framework modules, SQL errors, and more.

    sqlmap
    # sqlmap goal is to detect and take advantage of SQL injection 
    # vulnerabilities in web applications. Once it detects one or more 
    # SQL injections on the target host, the user can choose among a 
    # variety of options to perform an extensive back-end database 
    # management system fingerprint, retrieve DBMS session user and 
    # database, enumerate users, password hashes, privileges, 
    # databases, dump entire or user’s specific DBMS tables/columns, 
    # run his own SQL statement, read specific files on the file 
    # system and more. 

    hashcat
    # Hashcat supports five unique modes of attack for over 300 
    # highly-optimized hashing algorithms. hashcat currently supports 
    # CPUs, GPUs, and other hardware accelerators on Linux, and has 
    # facilities to help enable distributed password cracking. 
    # Examples of hashcat supported hashing algorithms are: MD5, 
    # HMAC-MD5, SHA1, HMAC-SHA1, MySQL323, MySQL4.1/MySQL5, phpass, 
    # MD5(Wordpress), MD5(phpBB3), MD5(Joomla), md5crypt, MD5(Unix), 
    # FreeBSD MD5, Cisco-IOS, MD4, NTLM, Domain Cached Credentials 
    # (DCC), MS Cache, SHA256, HMAC-SHA256, md5apr1, MD5(APR), Apache 
    # MD5, SHA512, HMAC-SHA512, Cisco-PIX, Cisco-ASA, WPA/WPA2, Double 
    # MD5, bcrypt, Blowfish(OpenBSD), MD5(Sun), Double SHA1, 
    # SHA-3(Keccak),Half MD5, Password Safe SHA-256, IKE-PSK MD5, 
    # IKE-PSK SHA1, NetNTLMv1-VANILLA/NetNTLMv1-ESS, NetNTLMv2, 
    # Cisco-IOS SHA256, Android PIN, AIX {smd5}, AIX {ssha256}, AIX 
    # {ssha512}, AIX {ssha1}, GOST, GOST R 34, Fortigate (FortiOS), OS 
    # X v10.8+, GRUB 2, IPMI2, RAKP, HMAC-SHA1, sha256crypt, 
    # SHA256(Unix), Drupal7, WBB3, scrypt, Cisco $8$, Cisco $9$, 
    # Radmin2, Django (PBKDF2-SHA256), Cram MD5, SAP, iSSHA-1, 
    # PrestaShop, PostgreSQL, Challenge-Response Authentication (MD5), 
    # MySQL Challenge-Response, Authentication (SHA1), SIP digest 
    # authentication (MD5), Plaintext, Joomla < 2.5.18, PostgreSQL, 
    # osCommerce, xt:Commerce, Skype, nsldap, Netscape, LDAP, nsldaps, 
    # SSHA-1(Base64), Oracle S: Type (Oracle 11+), SMF > v1.1, OS X 
    # v10.4, v10.5, v10.6, EPi, Django (SHA-1), MSSQL(2000), 
    # MSSQL(2005), PeopleSoft, EPiServer 6.x < v4, hMailServer, 
    # SSHA-512(Base64), LDAP {SSHA512}, OS X v10.7, MSSQL(2012 & 
    # 2014), vBulletin < v3.8.5, PHPS, vBulletin > v3.8.5, IPB2+, 
    # MyBB1.2+, Mediawiki B type, WebEdition CMS, Redmine. 
    # Hashcat offers multiple attack modes for obtaining effective and 
    # complex coverage over a hash’s keyspace. These modes are: 
    # Brute-Force attack
    # Combinator attack
    # Dictionary attack
    # Fingerprint attack
    # Hybrid attack
    # Mask attack
    # Permutation attack
    # Rule-based attack
    # Table-Lookup attack
    # Toggle-Case attack
    # PRINCE attack

    ######## maltego ######## [unfree]
    # Maltego is an open source intelligence and forensics 
    # application. It will offer you timous mining and gathering of 
    # information as well as the representation of this information in 
    # a easy to understand format. 
    # This package replaces previous packages matlegoce and casefile.

    autospy
    # The Autopsy Forensic Browser is a graphical interface to the 
    # command line digital forensic analysis tools in The Sleuth Kit. 
    # Together, The Sleuth Kit and Autopsy provide many of the same 
    # features as commercial digital forensics tools for the analysis 
    # of Windows and UNIX file systems (NTFS, FAT, FFS, EXT2FS, and 
    # EXT3FS). 

    sherlock
    # Sherlock relies on the site’s designers providing a unique URL 
    # for a registered username. To determine if a username is 
    # available, Sherlock queries that URL, and uses to response to 
    # understand if there is a claimed username already there. 
    # Currently, the tool is capable of locating users on more than 
    # 300 social networks: Apple Developer, Arduino, Docker Hub, 
    # GitHub, GitLab, Facebook, BitCoinForum, CNET, IFTTT, Instagram, 
    # PlayStore PyPI, Scribd, Telegram, TikTok, Tinder etc. 

    john
    # John the Ripper is a tool designed to help systems 
    # administrators to find weak (easy to guess or crack through 
    # brute force) passwords, and even automatically mail users 
    # warning them about it, if it is desired. 
    # Besides several crypt(3) password hash types most commonly found 
    # on various Unix flavors, supported out of the box are Kerberos 
    # AFS and Windows NT/2000/XP/2003 LM hashes, plus several more 
    # with contributed patches. 

    ######## burpsuite ######## [unfree]
    # Burp Suite is an integrated platform for performing security 
    # testing of web applications. Its various tools work seamlessly 
    # together to support the entire testing process, from initial 
    # mapping and analysis of an application’s attack surface, 
    # through to finding and exploiting security vulnerabilities. 
    # Burp gives you full control, letting you combine advanced manual 
    # techniques with state-of-the-art automation, to make your work 
    # faster, more effective, and more fun. 

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

    snort
    # Snort is a libpcap-based packet sniffer/logger which can be used 
    # as a lightweight network intrusion detection system. It features 
    # rules-based logging and can perform content searching/matching 
    # in addition to detecting a variety of other attacks and probes, 
    # such as buffer overflows, stealth port scans, CGI attacks, SMB 
    # probes, and much more. Snort has a real-time alerting 
    # capability, with alerts being sent to syslog, a separate 
    # “alert” file, or even to a Windows computer via Samba. 

    nikto
    # Nikto is a pluggable web server and CGI scanner written in Perl, 
    # using rfp’s LibWhisker to perform fast security or 
    # informational checks. 
    # Features:
    # Easily updatable CSV-format checks database
    # Output reports in plain text or HTML
    # Available HTTP versions automatic switching
    # Generic as well as specific server software checks
    # SSL support (through libnet-ssleay-perl)
    # Proxy support (with authentication)
    # Cookies support

     ######## wpscan ######## [unfree]
    # WPScan scans remote WordPress installations to find security 
    # issues. 

    responder
    # Specify the IP address to redirect to (-i 192.168.1.202), 
    # enabling the WPAD rogue proxy (-w On), answers for netbios 
    # wredir (-r On), and fingerprinting (-f On): 

    netcat
    # A simple Unix utility which reads and writes data across network 
    # connections using TCP or UDP protocol. It is designed to be a 
    # reliable “back-end” tool that can be used directly or easily 
    # driven by other programs and scripts. At the same time it is a 
    # feature-rich network debugging and exploration tool, since it 
    # can create almost any kind of connection you would need and has 
    # several interesting built-in capabilities. 
    # This is the “classic” netcat, written by Hobbit. It lacks 
    # many features found in netcat-openbsd. 

    ######## beef-xss ######## [not found]
    # BeEF is short for The Browser Exploitation Framework. It is a 
    # penetration testing tool that focuses on the web browser. 
    # Amid growing concerns about web-born attacks against clients, 
    # including mobile clients, BeEF allows the professional 
    # penetration tester to assess the actual security posture of a 
    # target environment by using client-side attack vectors. Unlike 
    # other security frameworks, BeEF looks past the hardened network 
    # perimeter and client system, and examines exploitability within 
    # the context of the one open door: the web browser. BeEF will 
    # hook one or more web browsers and use them as beachheads for 
    # launching directed command modules and further attacks against 
    # the system from within the browser context. 

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

    crunch
    # Crunch is a wordlist generator where you can specify a standard 
    # character set or any set of characters to be used in generating 
    # the wordlists. The wordlists are created through combination and 
    # permutation of a set of characters. You can determine the amount 
    # of characters and list size. 
    # This program supports numbers and symbols, upper and lower case 
    # characters separately and Unicode. 

    nuclei
    # This package contains a fast tool for configurable targeted 
    # scanning based on templates offering massive extensibility and 
    # ease of use. 
    # Nuclei is used to send requests across targets based on a 
    # template leading to zero false positives and providing fast 
    # scanning on large number of hosts. Nuclei offers scanning for a 
    # variety of protocols including TCP, DNS, HTTP, File, etc. With 
    # powerful and flexible templating, all kinds of security checks 
    # can be modelled with Nuclei. 

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

    ettercap
    # Ettercap supports active and passive dissection of many 
    # protocols (even encrypted ones) and includes many feature for 
    # network and host analysis. 
    # Data injection in an established connection and filtering 
    # (substitute or drop a packet) on the fly is also possible, 
    # keeping the connection synchronized. 
    # Many sniffing modes are implemented, for a powerful and complete 
    # sniffing suite. It is possible to sniff in four modes: IP Based, 
    # MAC Based, ARP Based (full-duplex) and PublicARP Based 
    # (half-duplex). 
    # Ettercap also has the ability to detect a switched LAN, and to 
    # use OS fingerprints (active or passive) to find the geometry of 
    # the LAN. 
    # This package contains the Common support files, configuration 
    # files, plugins, and documentation. You must also install either 
    # ettercap-graphical or ettercap-text-only for the actual 
    # GUI-enabled or text-only ettercap executable, respectively. 

    bloodhound
    # This package contains BloodHound Community Edition, a single 
    # page Javascript web application. 
    # BloodHound uses graph theory to reveal the hidden and often 
    # unintended relationships within an Active Directory environment. 
    # Attackers can use BloodHound to easily identify highly complex 
    # attack paths that would otherwise be impossible to quickly 
    # identify. Defenders can use BloodHound to identify and eliminate 
    # those same attack paths. Both blue and red teams can use 
    # BloodHound to easily gain a deeper understanding of privilege 
    # relationships in an Active Directory environment. 

    bettercap
    # The Swiss Army knife for 802.11, BLE, IPv4 and IPv6 networks 
    # reconnaissance and MITM attacks. 
    # bettercap is a powerful, easily extensible and portable 
    # framework written in Go which aims to offer to security 
    # researchers, red teamers and reverse engineers an easy to use, 
    # all-in-one solution with all the features they might possibly 
    # need for performing reconnaissance and attacking WiFi networks, 
    # Bluetooth Low Energy devices, wireless HID devices and Ethernet 
    # networks. 
    # Main Features:
    # WiFi networks scanning, deauthentication attack, clientless PMKID association attack and automatic WPA/WPA2 client handshakes capture.
    # Bluetooth Low Energy devices scanning, characteristics enumeration, reading and writing.
    # 2.4Ghz wireless devices scanning and MouseJacking attacks with over-the-air HID frames injection (with DuckyScript support).
    # Passive and active IP network hosts probing and recon.
    # ARP, DNS, NDP and DHCPv6 spoofers for MITM attacks on IPv4 and IPv6 based networks.
    # Proxies at packet level, TCP level and HTTP/HTTPS application level fully scriptable with easy to implement javascript plugins.
    # A powerful network sniffer for credentials harvesting which can also be used as a network protocol fuzzer.
    # A very fast port scanner.
    # A powerful REST API with support for asynchronous events notification on websocket to orchestrate your attacks easily.
    # A very convenient web UI.
    # More! (https://www.bettercap.org/modules/)

    steghide
    # Steghide is steganography program which hides bits of a data 
    # file in some of the least significant bits of another file in 
    # such a way that the existence of the data file is not visible 
    # and cannot be proven. 
    # Steghide is designed to be portable and configurable and 
    # features hiding data in bmp, jpeg, wav and au files, blowfish 
    # encryption, MD5 hashing of passphrases to blowfish keys, and 
    # pseudo-random distribution of hidden bits in the container data. 
    # Steghide is useful in digital forensics investigations. 

    ######## rkhunter ######## [not found]
    # Rootkit Hunter scans systems for known and unknown rootkits, 
    # backdoors, sniffers and exploits. 
    # It checks for:
    # SHA256 hash changes;
    # files commonly created by rootkits;
    # executables with anomalous file permissions;
    # suspicious strings in kernel modules;
    # hidden files in system directories; and can optionally scan within files.
    # Using rkhunter alone does not guarantee that a system is not 
    # compromised. Running additional tests, such as chkrootkit, is 
    # recommended. 

    macchanger
    # GNU MAC Changer is an utility that makes the maniputation of MAC 
    # addresses of network interfaces easier. MAC addresses are unique 
    # identifiers on networks, they only need to be unique, they can 
    # be changed on most network hardware. MAC addresses have started 
    # to be abused by unscrupulous marketing firms, government 
    # agencies, and others to provide an easy way to track a computer 
    # across multiple networks. By changing the MAC address regularly, 
    # this kind of tracking can be thwarted, or at least made a lot 
    # more difficult. 
    # Features:
    # set specific MAC address of a network interface
    # set the MAC randomly
    # set a MAC of another vendor
    # set another MAC of the same vendor
    # set a MAC of the same kind (eg: wireless card)
    # display a vendor MAC list (today, 6200 items) to choose from

    eyewitness
    # EyeWitness is designed to take screenshots of websites, provide 
    # some server header info, and identify default credentials if 
    # possible. 
    # EyeWitness is designed to run on Kali Linux. It will auto detect 
    # the file you give it with the -f flag as either being a text 
    # file with URLs on each new line, nmap xml output, or nessus xml 
    # output. The -t (timeout) flag is completely optional, and lets 
    # you provice the max time to wait when trying to render and 
    # screenshot a web page. The –open flag, which is optional, will 
    # open the URL in a new tab within Firefox. 

    ######## sqlsus ######## [not found]
    # sqlsus is an open source MySQL injection and takeover tool, 
    # written in perl. Via a command line interface, you can retrieve 
    # the database(s) structure, inject your own SQL queries (even 
    # complex ones), download files from the web server, crawl the 
    # website for writable directories, upload and control a backdoor, 
    # clone the database(s), and much more… Whenever relevant, 
    # sqlsus will mimic a MySQL console output. 

    ######## legion ######## [not found]
    # This package contains an open source, easy-to-use, 
    # super-extensible and semi-automated network penetration testing 
    # tool that aids in discovery, reconnaissance and exploitation of 
    # information systems. 
    # Legion is a fork of SECFORCE’s Sparta.

    foremost
    # Foremost is a forensic program to recover lost files based on 
    # their headers, footers, and internal data structures. 
    # Foremost can work on image files, such as those generated by dd, 
    # Safeback, Encase, etc, or directly on a drive. The headers and 
    # footers can be specified by a configuration file or you can use 
    # command line switches to specify built-in file types. These 
    # built-in types look at the data structures of a given file 
    # format allowing for a more reliable and faster recovery. 

    commix
    # This package contains Commix (short for [comm]and [i]njection 
    # e[x]ploiter). It has a simple environment and it can be used, 
    # from web developers, penetration testers or even security 
    # researchers to test web applications with the view to find bugs, 
    # errors or vulnerabilities related to command injection attacks. 
    # By using this tool, it is very easy to find and exploit a 
    # command injection vulnerability in a certain vulnerable 
    # parameter or string. Commix is written in Python programming 
    # language. 

    cewl
    # CeWL (Custom Word List generator) is a ruby app which spiders a 
    # given URL, up to a specified depth, and returns a list of words 
    # which can then be used for password crackers such as John the 
    # Ripper. Optionally, CeWL can follow external links. 
    # CeWL can also create a list of email addresses found in mailto 
    # links. These email addresses can be used as usernames in brute 
    # force actions. 
    # Another tool provided by CeWL project is FAB (Files Already 
    # Bagged). FAB extracts the content of the author/creator fields, 
    # from metadata of the some files, to create lists of possible 
    # usernames. These usernames can be used in association with the 
    # password list generated by CeWL. FAB uses the same metadata 
    # extraction techniques that CeWL. Currently, FAB process Office 
    # pre 2007, Office 2007 and PDF formats. 
    # CeWL is useful in security tests and forensics investigations. 
    # CeWL is pronounced “cool”. 

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

    netexec
    # NetExec (AKA nxc) is a network service exploitation tool that 
    # helps automate assessing the security of large networks. 
    # NetExec is the continuation of CrackMapExec, which was 
    # maintained by mpgn over the years, but discontinued upon 
    # mpgn’s retirement. 

    ######## dvwa ######## [not found]
    # This package contains a PHP/MySQL web application that is damn 
    # vulnerable. Its main goal is to be an aid for security 
    # professionals to test their skills and tools in a legal 
    # environment, help web developers better understand the processes 
    # of securing web applications and to aid both students & teachers 
    # to learn about web application security in a controlled class 
    # room environment. 
    # The aim of DVWA is to practice some of the most common web 
    # vulnerabilities, with various levels of difficulty, with a 
    # simple straightforward interface. Please note, there are both 
    # documented and undocumented vulnerabilities with this software. 
    # This is intentional. You are encouraged to try and discover as 
    # many issues as possible. 
    # WARNING: Do not upload it to your hosting provider’s public 
    # html folder or any Internet facing servers, as they will be 
    # compromised. 

    netexec ######## crackmapexec ######## [forked]
    # This package is a swiss army knife for pentesting Windows/Active 
    # Directory environments. 
    # From enumerating logged on users and spidering SMB shares to 
    # executing psexec style attacks, auto-injecting 
    # Mimikatz/Shellcode/DLL’s into memory using Powershell, dumping 
    # the NTDS.dit and more. 
    # The biggest improvements over the above tools are:
    # Pure Python script, no external tools required
    # Fully concurrent threading
    # Uses ONLY native WinAPI calls for discovering sessions, users, dumping SAM hashes etc…
    # Opsec safe (no binaries are uploaded to dump clear-text credentials, inject shellcode etc…)
    # Additionally, a database is used to store used/dumped 
    # credentals. It also automatically correlates Admin credentials 
    # to hosts and vice-versa allowing you to easily keep track of 
    # credential sets and gain additional situational awareness in 
    # large environments. 

    armitage
    # Armitage is a scriptable red team collaboration tool for 
    # Metasploit that visualizes targets, recommends exploits, and 
    # exposes the advanced post- exploitation features in the 
    # framework. 

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

    socat
    # Socat (for SOcket CAT) establishes two bidirectional byte 
    # streams and transfers data between them. Data channels may be 
    # files, pipes, devices (terminal or modem, etc.), or sockets 
    # (Unix, IPv4, IPv6, raw, UDP, TCP, SSL). It provides forking, 
    # logging and tracing, different modes for interprocess 
    # communication and many more options. 
    # It can be used, for example, as a TCP relay (one-shot or 
    # daemon), as an external socksifier, as a shell interface to Unix 
    # sockets, as an IPv6 relay, as a netcat and rinetd replacement, 
    # to redirect TCP-oriented programs to a serial line, or to 
    # establish a relatively secure environment (su and chroot) for 
    # running client or server shell scripts inside network 
    # connections. Socat supports sctp as of 1.7.0. 

    ######## sara ######## [not found]
    # This package contains an autonomous RouterOS configuration 
    # analyzer for finding security issues on MikroTik hardware. 

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

    ######## pompem ######## [not found]
    # Find exploit with a system of advanced search, designed to 
    # automate the search for Exploits and Vulnerability in the most 
    # important databases facilitating the work of pentesters, ethical 
    # hackers and forensics expert. Performs searches in databases: 
    # PacketStorm security, CXSecurity, ZeroDay, Vulners, National 
    # Vulnerability Database, WPScan Vulnerability Database. This tool 
    # is essential in the security of networks and systems. 
    # The search results can be exported to HTML or text format.

    mdk3-master ######## mdk3 ######## [forked]
    # MDK is a proof-of-concept tool to exploit common IEEE 802.11 (Wi-Fi) protocol weaknesses. Features:
    # Bruteforce MAC Filters.
    # Bruteforce hidden SSIDs (some small SSID wordlists included).
    # Probe networks to check if they can hear you.
    # Intelligent Authentication-DoS to freeze APs (with success checks).
    # FakeAP - Beacon Flooding with channel hopping (can crash NetStumbler and some buggy drivers)
    # Disconnect everything (aka AMOK-MODE) with Deauthentication and Disassociation packets.
    # WPA TKIP Denial-of-Service.
    # WDS Confusion - Shuts down large scale multi-AP installations.

    masscan
    # MASSCAN is TCP port scanner which transmits SYN packets 
    # asynchronously and produces results similar to nmap, the most 
    # famous port scanner. Internally, it operates more like scanrand, 
    # unicornscan, and ZMap, using asynchronous transmission. It’s a 
    # flexible utility that allows arbitrary address and port ranges. 

    hash-identifier
    # Software to identify the different types of hashes used to 
    # encrypt data and especially passwords. 

    ffuf
    # ffuf is a fast web fuzzer written in Go that allows typical 
    # directory discovery, virtual host discovery (without DNS 
    # records) and GET and POST parameter fuzzing. 
    # This program is useful for pentesters, ethical hackers and 
    # forensics experts. It also can be used for security tests. 

    evil-winrm
    # This package contains the ultimate WinRM shell for 
    # hacking/pentesting. 
    # WinRM (Windows Remote Management) is the Microsoft 
    # implementation of WS-Management Protocol. A standard SOAP based 
    # protocol that allows hardware and operating systems from 
    # different vendors to interoperate. Microsoft included it in 
    # their Operating Systems in order to make life easier to system 
    # administrators. 
    # This program can be used on any Microsoft Windows Servers with 
    # this feature enabled (usually at port 5985), of course only if 
    # you have credentials and permissions to use it. So it could be 
    # used in a post-exploitation hacking/pentesting phase. The 
    # purpose of this program is to provide nice and easy-to-use 
    # features for hacking. It can be used with legitimate purposes by 
    # system administrators as well but the most of its features are 
    # focused on hacking/pentesting stuff. 
    # It is using PSRP (Powershell Remoting Protocol) for initializing 
    # runspace pools as well as creating and processing pipelines. 

    ######## dirsearch ######## [not found]
    # This package contains is a command-line tool designed to brute 
    # force directories and files in webservers. 
    # As a feature-rich tool, dirsearch gives users the opportunity to 
    # perform a complex web content discovering, with many vectors for 
    # the wordlist, high accuracy, impressive performance, advanced 
    # connection/request settings, modern brute-force techniques and 
    # nice output. 

    chkrootkit
    # The chkrootkit security scanner searches for signs that the 
    # system is infected with a ‘rootkit’. Rootkits are a form of 
    # malware that seek to exploit security flaws to grant 
    # unauthorised access to a computer or its services, generally for 
    # malicious purposes. 
    # chkrootkit can identify signs of over 70 different rootkits (see 
    # the project’s website for a list). 
    # Please note that an automated tool like chkrootkit can never 
    # guarantee a system is uncompromised. Nor does every report 
    # always signify a genuine problem: human judgement and further 
    # investigation will always be needed to assure the security of 
    # your system. 

    arping
    # The arping utility sends ARP and/or ICMP requests to the 
    # specified host and displays the replies. The host may be 
    # specified by its hostname, its IP address, or its MAC address. 

    yersinia
    # Yersinia is a framework for performing layer 2 attacks. It is 
    # designed to take advantage of some weakeness in different 
    # network protocols. It pretends to be a solid framework for 
    # analyzing and testing the deployed networks and systems. 
    # Attacks for the following network protocols are implemented in this particular release:
    # Spanning Tree Protocol (STP).
    # Cisco Discovery Protocol (CDP).
    # Dynamic Trunking Protocol (DTP).
    # Dynamic Host Configuration Protocol (DHCP).
    # Hot Standby Router Protocol (HSRP).
    # 802.1q.
    # 802.1x.
    # Inter-Switch Link Protocol (ISL).
    # VLAN Trunking Protocol (VTP).

    subfinder
    # This package contains a subdomain discovery tool that discovers 
    # valid subdomains for websites by using passive online sources. 
    # It has a simple modular architecture and is optimized for speed. 
    # subfinder is built for doing one thing only - passive subdomain 
    # enumeration, and it does that very well. 

    medusa
    # Medusa is intended to be a speedy, massively parallel, modular, 
    # login brute-forcer. The goal is to support as many services 
    # which allow remote authentication as possible. The author 
    # considers following items as some of the key features of this 
    # application: * Thread-based parallel testing. Brute-force 
    # testing can be performed against multiple hosts, users or 
    # passwords concurrently. * Flexible user input. Target 
    # information (host/user/password) can be specified in a variety 
    # of ways. For example, each item can be either a single entry or 
    # a file containing multiple entries. Additionally, a combination 
    # file format allows the user to refine their target listing. * 
    # Modular design. Each service module exists as an independent 
    # .mod file. This means that no modifications are necessary to the 
    # core application in order to extend the supported list of 
    # services for brute-forcing. 

    lbd
    # Checks if a given domain uses load-balancing.

    villain ######## hoaxshell ######## [not found]
    # Hoaxshell is a Windows reverse shell payload generator and 
    # handler that abuses the http(s) protocol to establish a 
    # beacon-like reverse shell 

    ######## havoc ######## [not found]
    # Havoc is a modern, malleable post-exploitation command and 
    # control framework made for penetration testers, red teams, and 
    # blue teams. 

    enum4linux
    # Enum4linux is a tool for enumerating information from Windows 
    # and Samba systems. It attempts to offer similar functionality to 
    # enum.exe formerly available from www.bindview.com. 
    # It is written in PERL and is basically a wrapper around the 
    # Samba tools smbclient, rpclient, net and nmblookup. The samba 
    # package is therefore a dependency. 

    capstone
    # Capstone is a lightweight multi-platform, multi-architecture 
    # disassembly framework. 
    # This package contains cstool, a command-line tool to disassemble 
    # hexadecimal strings. 

    ######## arpwatch ######## [not found]
    # Arpwatch maintains a database of Ethernet MAC addresses seen on 
    # the network, with their associated IP pairs. Alerts the system 
    # administrator via e-mail if any change happens, such as new 
    # station/activity, flip-flops, changed and re-used old addresses. 
    # If you want to maintain a list authorized MAC addresses 
    # manually, take a look at the arpalert package which may fit your 
    # needs better. 

    above
    # This package contains an invisible protocol sniffer for finding 
    # vulnerabilities in the network, designed for pentesters and 
    # security professionals. 
    # It is based entirely on network traffic analysis, so it does not 
    # make any noise on the air. Above allows pentesters to automate 
    # the process of finding vulnerabilities in network hardware. 
    # Discovery protocols, dynamic routing, FHRP, STP, LLMNR/NBT-NS, 
    # etc. 
    # The tool can also both listen to traffic on the interface and 
    # analyze already existing pcap files. 

    yara
    # YARA is a tool aimed at helping malware researchers to identify 
    # and classify malware samples. With YARA, it is possible to 
    # create descriptions of malware families based on textual or 
    # binary patterns contained in samples of those families. Each 
    # description consists of a set of strings and a Boolean 
    # expression which determines its logic. 
    # Complex and powerful rules can be created by using binary 
    # strings with wild-cards, case-insensitive text strings, special 
    # operators, regular expressions and many other features. 

    testdisk
    # TestDisk checks the partition and boot sectors of your disks. It 
    # is very useful in forensics, recovering lost partitions. It 
    # works with : 
    # DOS/Windows FAT12, FAT16 and FAT32
    # NTFS ( Windows NT/2K/XP )
    # Linux Ext2 and Ext3
    # BeFS ( BeOS )
    # BSD disklabel ( FreeBSD/OpenBSD/NetBSD )
    # CramFS (Compressed File System)
    # HFS and HFS+, Hierarchical File System
    # JFS, IBM’s Journaled File System
    # Linux Raid
    # Linux Swap (versions 1 and 2)
    # LVM and LVM2, Linux Logical Volume Manager
    # Netware NSS
    # ReiserFS 3.5 and 3.6
    # Sun Solaris i386 disklabel
    # UFS and UFS2 (Sun/BSD/…)
    # XFS, SGI’s Journaled File System
    # PhotoRec is file data recovery software designed to recover lost 
    # pictures from digital camera memory or even Hard Disks. It has 
    # been extended to search also for non audio/video headers. It 
    # searches for following files and is able to undelete them: 
    # Sun/NeXT audio data (.au)
    # RIFF audio/video (.avi/.wav)
    # BMP bitmap (.bmp)
    # bzip2 compressed data (.bz2)
    # Source code written in C (.c)
    # Canon Raw picture (.crw)
    # Canon catalog (.ctg)
    # FAT subdirectory
    # Microsoft Office Document (.doc)
    # Nikon dsc (.dsc)
    # HTML page (.html)
    # JPEG picture (.jpg)
    # MOV video (.mov)
    # MP3 audio (MPEG ADTS, layer III, v1) (.mp3)
    # Moving Picture Experts Group video (.mpg)
    # Minolta Raw picture (.mrw)
    # Olympus Raw Format picture (.orf)
    # Portable Document Format (.pdf)
    # Perl script (.pl)
    # Portable Network Graphics (.png)
    # Raw Fujifilm picture (.raf)
    # Contax picture (.raw)
    # Rollei picture (.rdc)
    # Rich Text Format (.rtf)
    # Shell script (.sh)
    # Tar archive (.tar )
    # Tag Image File Format (.tiff)
    # Microsoft ASF (.wma)
    # Sigma/Foveon X3 raw picture (.x3f)
    # zip archive (.zip)

    xsubfind3r ######## sublist3r ######## [not found]
    # This package contains a Python security tool designed to 
    # enumerate subdomains of websites using OSINT. It helps 
    # penetration testers and bug hunters collect and gather 
    # subdomains for the domain they are targeting over the network. 
    # Sublist3r enumerates subdomains using many search engines such 
    # as Google, Yahoo, Bing, Baidu, and Ask. Sublist3r also 
    # enumerates subdomains using Netcraft, Virustotal, ThreatCrowd, 
    # DNSdumpster, and ReverseDNS. 
    # Subbrute was integrated with Sublist3r to increase the 
    # possibility of finding more subdomains using bruteforce with an 
    # improved wordlist. 

    python313Packages.scapy
    # Scapy is a powerful interactive packet manipulation tool, packet 
    # generator, network scanner, network discovery, packet sniffer, 
    # etc. It can for the moment replace hping, 85% of nmap, arpspoof, 
    # arp-sk, arping, tcpdump, tethereal, p0f, …. 
    # In scapy you define a set of packets, then it sends them, 
    # receives answers, matches requests with answers and returns a 
    # list of packet couples (request, answer) and a list of unmatched 
    # packets. This has the big advantage over tools like nmap or 
    # hping that an answer is not reduced to (open/closed/filtered), 
    # but is the whole packet. 
    # This package contains the Python 3 version of the library and 
    # scapy executable. 

    ######## rubeus ######## [not found]
    # Rubeus is a C# toolset for raw Kerberos interaction and abuses. 
    # It is heavily adapted from Benjamin Delpy’s Kekeo project and 
    # Vincent LE TOUX’s MakeMeEnterpriseAdmin project. 

    mitmproxy
    # mitmproxy is an interactive man-in-the-middle proxy for HTTP and 
    # HTTPS. It provides a console interface that allows traffic flows 
    # to be inspected and edited on the fly. 
    # Also shipped is mitmdump, the command-line version of mitmproxy, 
    # with the same functionality but without the frills. Think 
    # tcpdump for HTTP. 
    # Features:
    # intercept and modify HTTP and HTTPS requests and responses and modify them on the fly
    # save HTTP conversations for later replay and analysis
    # replay the client-side of an HTTP conversation
    # reverse proxy mode to forward traffic to a specified server
    # transparent proxy mode on OSX and Linux
    # make scripted changes to HTTP traffic using Python
    # SSL/TLS certificates for interception are generated on the fly
    # This package contains the python-pathod module (previously 
    # provided by other source package). The python-netlib module was 
    # also included but it has been dropped by upstream in version 
    # 1.0. 

    mimikatz
    # Mimikatz uses admin rights on Windows to display passwords of 
    # currently logged in users in plaintext. 

    ######## metagoofil ######## [not found]
    # Metagoofil is an information gathering tool designed for 
    # extracting metadata of public documents 
    # (pdf,doc,xls,ppt,docx,pptx,xlsx) belonging to a target company. 
    # Metagoofil will perform a search in Google to identify and 
    # download the documents to local disk. Metagoofil does no longer 
    # extract the metadata. See 
    # /usr/share/doc/metagoofil/README.md.gz. 

    ligolo-ng
    # Ligolo-ng is a simple, lightweight and fast tool that allows 
    # pentesters to establish tunnels from a reverse TCP/TLS 
    # connection using a tun interface (without the need of SOCKS). 

    ######## goldeneye ######## [not found]
    # GoldenEye is a HTTP DoS Test Tool. This tool can be used to test 
    # if a site is susceptible to Deny of Service (DoS) attacks. Is 
    # possible to open several parallel connections against a URL to 
    # check if the web server can be compromised. 
    # The program tests the security in networks and uses ‘HTTP Keep Alive
    # NoCache’ as attack vector.
    # This package is useful for pentesters.

    ghidra
    # This package contains a software reverse engineering (SRE) 
    # framework created and maintained by the National Security Agency 
    # Research Directorate. This framework includes a suite of 
    # full-featured, high-end software analysis tools that enable 
    # users to analyze compiled code on a variety of platforms 
    # including Windows, macOS, and Linux. Capabilities include 
    # disassembly, assembly, decompilation, graphing, and scripting, 
    # along with hundreds of other features. Ghidra supports a wide 
    # variety of processor instruction sets and executable formats and 
    # can be run in both user-interactive and automated modes. Users 
    # may also develop their own Ghidra extension components and/or 
    # scripts using Java or Python. 
    # In support of NSA’s Cybersecurity mission, Ghidra was built to 
    # solve scaling and teaming problems on complex SRE efforts, and 
    # to provide a customizable and extensible SRE research platform. 
    # NSA has applied Ghidra SRE capabilities to a variety of problems 
    # that involve analyzing malicious code and generating deep 
    # insights for SRE analysts who seek a better understanding of 
    # potential vulnerabilities in networks and systems. 

    ######## dnscat2 ######## [not found]
    # This tool is designed to create an encrypted command-and-control 
    # (C&C) channel over the DNS protocol, which is an effective 
    # tunnel out of almost every network. 

    crowbar
    # This package contains Crowbar (formally known as Levye). It is a 
    # brute forcing tool that can be used during penetration tests. It 
    # was developed to brute force some protocols in a different 
    # manner according to other popular brute forcing tools. As an 
    # example, while most brute forcing tools use username and 
    # password for SSH brute force, Crowbar uses SSH key(s). This 
    # allows for any private keys that have been obtained during 
    # penetration tests, to be used to attack other SSH servers. 
    # Currently Crowbar supports: * OpenVPN (-b openvpn) * Remote 
    # Desktop Protocol (RDP) with NLA support (-b rdp) * SSH private 
    # key authentication (-b sshkey) * VNC key authentication (-b vpn) 

    chirp
    # CHIRP is a free, open-source tool for programming your amateur 
    # radio. It supports a large number of manufacturers and models, 
    # as well as provides a way to interface with multiple data 
    # sources and formats. 
    # CHIRP can handle data in the following formats:
    # Comma Separated Values (.csv)
    # Comma Separated Values generated by RT Systems (.csv)
    # EVE for Yaesu VX-5 (.eve)
    # Kenwood HMK format (.hmk)
    # Kenwood commercial ITM format (.itm)
    # Icom Data Files (.icf)
    # ARRL TravelPlus (.tpe)
    # VX5 Commander Files (.vx5)
    # VX7 Commander Files (.vx7)
    # Most popular modern amateur radios are supported by CHIRP via their interface cables.    

    cadaver
    # cadaver supports file upload, download, on-screen display, 
    # in-place editing, namespace operations (move/copy), collection 
    # creation and deletion, property manipulation, and resource 
    # locking. 
    # Its operation is similar to the standard BSD ftp(1) client and 
    # the Samba Project’s smbclient(1). 
    # This package includes GnuTLS (HTTPS) support.
    # WebDAV (Web-based Distributed Authoring and Versioning) is a set 
    # of extensions to the HTTP protocol which allow users to 
    # collaboratively edit and manage files on remote web servers. 

    ######## zaproxy ######## [notfound]
    # The OWASP Zed Attack Proxy (ZAP) is an easy to use integrated 
    # penetration testing tool for finding vulnerabilities in web 
    # applications. 
    # It is designed to be used by people with a wide range of 
    # security experience and as such is ideal for developers and 
    # functional testers who are new to penetration testing as well as 
    # being a useful addition to an experienced pen testers toolbox. 
  ];
}
