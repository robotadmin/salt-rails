include:
  - rvm
  - ruby

{% set user = pillar['gemset_user'] %}

{{user}}_rails3.2.13:
  rvm.gemset_present:
    - ruby: 2.0.0
    - runas: {{user}}
    - require:
      - rvm: ruby-2.0.0

install rails:
  cmd.run:
    - name: /home/{{user}}/.rvm/bin/rvm 2.0.0@{{user}}_rails3.2.13 do gem install rails --version 3.2.13
    - user: {{user}}
    - shell: /bin/bash

