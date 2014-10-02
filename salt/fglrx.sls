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

unzip-fglrx:
  archive:
    - extracted
    - name: {{ user_home }}/Downloads/fglrx-14.301.1001
    - source: http://www2.ati.com/drivers/linux/amd-catalyst-14-9-linux-x86-x86-64.zip
    - source_hash: md5=525be162418929e8049d356a0bdee8fb
    - archive_format: zip
    - user: {{ user }}
    - require:
      - pkg: fglrx-deps

generate-pkgs:
  cmd.run: 
    - name: sh amd-driver-installer-14.301.1001-x86.x86_64.run --buildpkg Ubuntu/trusty
    - cwd: {{ user_home }}/Downloads/fglrx-14.301.1001
    - user: {{ user }}
    - require:
      - archive: unzip-fglrx


