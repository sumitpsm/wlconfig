{ pkgs, ... }:

{
  fonts.packages = with pkgs; [
    roboto-flex
    nerd-fonts.ubuntu-sans
    nerd-fonts.ubuntu-mono
    nerd-fonts.symbols-only
    nerd-fonts.space-mono
    nerd-fonts.sauce-code-pro
    nerd-fonts.roboto-mono
    nerd-fonts.noto
    nerd-fonts.liberation
    nerd-fonts.jetbrains-mono
    nerd-fonts.inconsolata-go
    nerd-fonts.inconsolata
    nerd-fonts.im-writing
    nerd-fonts.hasklug
    nerd-fonts.hack
    nerd-fonts.fira-mono
    nerd-fonts.fira-code
    nerd-fonts.fantasque-sans-mono
    nerd-fonts.droid-sans-mono
    nerd-fonts.dejavu-sans-mono
    nerd-fonts.cousine
    nerd-fonts.commit-mono
    nerd-fonts.comic-shanns-mono
    nerd-fonts.code-new-roman
    nerd-fonts.caskaydia-mono
    nerd-fonts.blex-mono
    nerd-fonts.adwaita-mono
    nerd-fonts._0xproto
  ];
}
