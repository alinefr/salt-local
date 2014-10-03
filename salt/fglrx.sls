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
  file.managed:
    - name: {{ user_home }}/Downloads/amd-catalyst-14-9-linux-x86-x86-64.zip
    - source: http://www2.ati.com/drivers/linux/amd-catalyst-14-9-linux-x86-x86-64.zip
    - source_hash: md5=117f757f941c885ec1b771517551a602
    - replace: False
    - require: 
      - pkg: fglrx-deps

  module.wait:
    - name: archive.unzip
    - zipfile: {{ user_home }}/Downloads/amd-catalyst-14-9-linux-x86-x86-64.zip
    - dest: {{ user_home }}/Downloads
    - options: -uo
    - watch:
      - file: download-fglrx

generate-pkgs:
  cmd.wait: 
    - name: sh amd-driver-installer-14.301.1001-x86.x86_64.run --buildpkg Ubuntu/trusty
    - cwd: {{ user_home }}/Downloads/fglrx-14.301.1001
    - watch: 
      - module: download-fglrx

install-fglrx-pkgs:
  pkg.installed:
    - sources:
      - fglrx: {{ user_home }}/Downloads/fglrx-14.301.1001/fglrx_14.301-0ubuntu1_amd64.deb
      - fglrx-amdcccle: {{ user_home }}/Downloads/fglrx-14.301.1001/fglrx-amdcccle_14.301-0ubuntu1_amd64.deb
      - fglrx-dev: {{ user_home }}/Downloads/fglrx-14.301.1001/fglrx-dev_14.301-0ubuntu1_amd64.deb
    - require:
      - cmd: generate-pkgs

