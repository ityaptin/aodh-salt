{%- from "aodh/map.jinja" import server with context %}
{%- if server.enabled and server.version == "mitaka" %}

server_packages:
  pkg.installed:
  - names: {{ server.pkgs }}

/etc/aodh/aodh.conf:
  file.managed:
  - source: salt://aodh/files/{{ server.version }}/aodh.conf.{{ grains.os_family }}
  - template: jinja
  - require:
    - pkg: server_packages

ceilometer_server_services:
  service.running:
  - names: {{ server.all_services }}
  - enable: true
  - watch:
    - file: /etc/aodh/aodh.conf

{%- endif %}
