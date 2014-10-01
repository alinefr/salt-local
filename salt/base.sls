caffeine-ppa:
  pkgrepo.managed:
    - humanname: Caffeine Developers PPA
    - name: deb http://ppa.launchpad.net/caffeine-developers/ppa/ubuntu trusty main
    - dist: trusty
    - file: /etc/apt/sources.list.d/caffeine.list
    - keyid: 569113AE
    - keyserver: keyserver.ubuntu.com

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
      - mutt
      - mutt-patched
      - urlview
      - htop


