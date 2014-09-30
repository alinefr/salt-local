{% set user = pillar['user'] %}

mutt-remove-unused:
  pkg.removed:
    - pkg: postfix

mutt-deps:
  pkg.latest:
    - pkgs:
      - mutt
      - mutt-patched
      - urlview

mutt-config:
  file.managed:
    - name: ~{{ user }}/.muttrc
    - source: salt://mutt/muttrc
    - user: {{ user }}
    - mode: 0600
    - template: jinja
    - require:
      - pkg: mutt-deps

