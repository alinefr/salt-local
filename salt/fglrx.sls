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

download-fglrx:
  cmd.run:
    - name: wget -nc http://www2.ati.com/drivers/linux/amd-catalyst-14-9-linux-x86-x86-64.zip
    - cwd: {{ user_home }}/Downloads
    - user: {{ user }}
    - require: 
      - pkg: fglrx-deps

  module.run:
    - name: archive.unzip
    - zipfile: {{ user_home }}/Downloads/amd-catalyst-14-9-linux-x86-x86-64.zip
    - dest: {{ user_home }}/Downloads
    - user: {{ user }}
    - require:
      - cmd: download-fglrx
    - unless: test -d {{ user_home }}/Downloads/fglrx-14.301.1001

generate-pkgs:
  cmd.run: 
    - name: sh amd-driver-installer-14.301.1001-x86.x86_64.run --buildpkg Ubuntu/trusty
    - cwd: {{ user_home }}/Downloads/fglrx-14.301.1001
    - user: {{ user }}
    - require:
      - module: download-fglrx


