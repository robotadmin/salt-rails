include:
  - rvm
  - ruby

{% set user = pillar['ruby_config']['gemset_user'] %}
{% set rails_versions = pillar['rails_config']['versions'] %}
{% set rails_ruby_name = pillar['rails_config']['ruby_name'] %}
{% set rails_ruby_version = pillar['rails_config']['ruby_version'] %}

{% for rails_version in rails_versions %}
{% set gemset_name = "%s_%s_rails-%s"%(user,rails_ruby_name,rails_version) %}
{{gemset_name}}:
  rvm.gemset_present:
    - ruby: {{rails_ruby_version}}
    - runas: {{user}}
    - require:
      - rvm: {{rails_ruby_name}}
{% endfor %}

install rails:
  {% for rails_version in rails_versions %}
  {% set gemset_name = "%s_%s_rails%s"%(user,rails_ruby_name,rails_version) %}
  cmd.run:
    - name: /home/{{user}}/.rvm/bin/rvm {{rails_ruby_version}}@{{gemset_name}} do gem install rails --version {{rails_version}}
    - user: {{user}}
    - shell: /bin/bash
  {% endfor %}
