caffeine-ppa:
  pkgrepo.managed:
    - humanname: Caffeine Developers PPA
    - name: deb http://ppa.launchpad.net/caffeine-developers/ppa/ubuntu trusty main
    - dist: trusty
    - file: /etc/apt/sources.list.d/caffeine.list
    - keyid: 569113AE
    - keyserver: keyserver.ubuntu.com

osd-lyrics-ppa:
  pkgrepo.managed:
    - ppa: osd-lyrics/ppa
  pkg.latest:
    - name: osdlyrics
    - refresh: True

pkg-removed:
  pkg.removed:
    - pkgs:
      - rhythmbox
      - postfix

pkg-installed:
  pkg.latest:
    - pkgs:
      - python-apt
      - banshee
      - caffeine
      - htop
      - python-matplotlib 
      - vim-gtk




