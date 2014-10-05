ppa-required:
  pkg.latest:
    - pkgs:
      - python-apt
      - python-software-properties

caffeine-ppa:
  pkgrepo.managed:
    - humanname: Caffeine Developers PPA
    - name: deb http://ppa.launchpad.net/caffeine-developers/ppa/ubuntu trusty main
    - dist: trusty
    - file: /etc/apt/sources.list.d/caffeine.list
    - keyid: 569113AE
    - keyserver: keyserver.ubuntu.com
    - require: 
      - pkg: ppa-required

pkg-removed:
  pkg.removed:
    - pkgs:
      - rhythmbox
      - postfix

pkg-installed:
  pkg.latest:
    - pkgs:
      - banshee
      - caffeine
      - htop
      - python-matplotlib 
      - vim-gtk
      - openjdk-7-jdk



