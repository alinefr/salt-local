python-apt:
  pkg.installed

pkg.upgrade:
  module.run:
    - require: 
      - pkg: python-apt

banshee:
  pkg.installed

