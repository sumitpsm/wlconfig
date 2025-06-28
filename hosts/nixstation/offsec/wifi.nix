{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # wifite           wifite2
    # reaver           reaverwps-t6x         reaverwps
    # pixieWPS
    # bettercap
    kismet

    wifite2
    # Wifite is a tool to audit WEP or WPA encrypted wireless 
    # networks. It uses aircrack-ng, pyrit, reaver, tshark tools to 
    # perform the audit. 
    # This tool is customizable to be automated with only a few 
    # arguments and can be trusted to run without supervision. 

    airgorah ######## aircrack-ng ######## [not found]
    # aircrack-ng is an 802.11a/b/g WEP/WPA cracking program that can 
    # recover a 40-bit, 104-bit, 256-bit or 512-bit WEP key once 
    # enough encrypted packets have been gathered. Also it can attack 
    # WPA1/2 networks with some advanced methods or simply by brute 
    # force.
    # It implements the standard FMS attack along with some 
    # optimizations, thus making the attack much faster compared to 
    # other WEP cracking tools. It can also fully use a multiprocessor 
    # system to its full power in order to speed up the cracking 
    # process. 
    # aircrack-ng is a fork of aircrack, as that project has been 
    # stopped by the upstream maintainer. 

    ######## fern-wifi-cracker ######## [not found]
    # This package contains a Wireless security auditing and attack 
    # software program written using the Python Programming Language 
    # and the Python Qt GUI library, the program is able to crack and 
    # recover WEP/WPA/WPS keys and also run other network based 
    # attacks on wireless or ethernet based networks. 

    reaverwps reaverwps-t6x
    # Reaver performs a brute force attack against an access point’s 
    # Wi-Fi Protected Setup pin number. Once the WPS pin is found, the 
    # WPA PSK can be recovered and alternately the AP’s wireless 
    # settings can be reconfigured. This package also provides the 
    # Wash executable, an utility for identifying WPS enabled access 
    # points. See documentation in /usr/share/doc/reaver/README.WASH. 

    bully
    # Bully is a new implementation of the WPS brute force attack, 
    # written in C. It is conceptually identical to other programs, in 
    # that it exploits the (now well known) design flaw in the WPS 
    # specification. It has several advantages over the original 
    # reaver code. These include fewer dependencies, improved memory 
    # and cpu performance, correct handling of endianness, and a more 
    # robust set of options. 

    ######## wifipumpkin3 ######## [not found]
    # This package contains a powerful framework for rogue access 
    # point attack, written in Python, that allow and offer to 
    # security researchers, red teamers and reverse engineers to mount 
    # a wireless network to conduct a man-in-the-middle attack. 

    ######## sparrow-wifi ######## [not found]
    # This package contains a graphical Wi-Fi analyzer for Linux. It 
    # provides a more comprehensive GUI-based replacement for tools 
    # like inSSIDer and linssid that runs specifically on Linux. In 
    # its most comprehensive use cases, sparrow-wifi integrates Wi-Fi, 
    # software-defined radio (hackrf), advanced bluetooth tools 
    # (traditional and Ubertooth), traditional GPS (via gpsd), and 
    # drone/rover GPS via mavlink in one solution. 

    ######## wifiphisher ######## [not found]
    # This package contains a security tool that mounts automated 
    # phishing attacks against Wi-Fi networks in order to obtain 
    # secret passphrases or other credentials. It is a social 
    # engineering attack that unlike other methods it does not include 
    # any brute forcing. It is an easy way for obtaining credentials 
    # from captive portals and third party login pages or WPA/WPA2 
    # secret passphrases. 

    airgeddon
    # airgeddon is a menu driven 3rd party tools wrapper to audit 
    # wireless networks with many features. 
  ];
}
