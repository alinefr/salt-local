{% set user = pillar['user'] %}
{% set user_home = salt['user.info'](user).home %}

ipython-pkgs:
  pkg.latest:
      - ipython-qtconsole
      - ipython-notebook

ipython-qtconsole-config:
  cmd.run:
    - name: ipython profile create
    - user: {{ user }}
    - require: 
      - pkg: ipython-pkgs
    - unless: ipython profile list | grep default

  file.managed:
    - name: {{ user_home }}/.config/ipython/profile_default/ipython_config.py
    - source: salt://ipython/ipython_qtconsole_config.py
    - user: {{ user }}
    - require:
      - cmd: ipython-qtconsole-config


