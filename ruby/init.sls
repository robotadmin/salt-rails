{% set user = pillar['gemset_user'] %}

{{user}}:
  group:
    - present
  user.present:
    - home: /home/{{user}}
    - shell: /bin/bash
    - groups:
      - {{user}}
      - rvm
    - require:
      - group: {{user}}
      - group: rvm

ruby-1.9.3:
  rvm.installed:
    - default: True
    - runas: {{user}}
    - require:
      - pkg: rvm-deps
      - pkg: mri-deps
      - user: {{user}}

ruby-2.0.0:
  rvm.installed:
    - default: True
    - runas: {{user}}
    - require:
      - pkg: rvm-deps
      - pkg: mri-deps
      - user: {{user}}
