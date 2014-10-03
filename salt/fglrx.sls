{% set user = pillar['user'] %}
{% set user_home = salt['user.info'](user).home %}

fglrx-deps:
  pkg.latest:
    - pkgs:
      - libqtgui4
      - dh-make
      - dh-modaliases 
      - execstack 
      - libc6-i386 
      - lib32gcc1
      - unzip
      - xserver-xorg-dev

download-fglrx:
  cmd.run:
    - name: wget -nc http://www2.ati.com/drivers/linux/amd-catalyst-14-9-linux-x86-x86-64.zip
    - cwd: {{ user_home }}/Downloads
    - require: 
      - pkg: fglrx-deps

  module.run:
    - name: archive.unzip
    - zipfile: {{ user_home }}/Downloads/amd-catalyst-14-9-linux-x86-x86-64.zip
    - dest: {{ user_home }}/Downloads
    - options: -uo
    - require:
      - cmd: download-fglrx

generate-pkgs:
  cmd.run: 
    - name: sh amd-driver-installer-14.301.1001-x86.x86_64.run --buildpkg Ubuntu/trusty
    - cwd: {{ user_home }}/Downloads/fglrx-14.301.1001
    - onchanges: 
      - cmd: download-fglrx

install-fglrx-pkgs:
  pkg.installed:
    - sources:
      - fglrx: {{ user_home }}/Downloads/fglrx-14.301.1001/fglrx_14.301-0ubuntu1_amd64.deb
      - fglrx-amdcccle: {{ user_home }}/Downloads/fglrx-14.301.1001/fglrx-amdcccle_14.301-0ubuntu1_amd64.deb
      - fglrx-dev: {{ user_home }}/Downloads/fglrx-14.301.1001/fglrx-dev_14.301-0ubuntu1_amd64.deb

