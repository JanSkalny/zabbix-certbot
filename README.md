# zabbix-certbot
Zabbix template for certbot / letsencrypt monitoring

## Installation
1. Import template & value mappings (`template.xml`).
2. Add "Template certbot" template to your hosts / groups.
2. Install `zabbix_certbot.sh` script:
```
cp zabbix_certbot.sh /usr/local/bin/zabbix_certbot.sh
chmod a+rx /usr/local/bin/zabbix_certbot.sh
```
4. Allow zabbix user to run `zabbix_certbot.sh` as root
```
cp sudoers /etc/sudoers.d/zabbix-certbot
```
5. Add certbot specific *UserParameter*s to zabbix-agent:
```
cp certbot.conf /etc/zabbix/zabbix_agentd.d/
```
6. Install dependencies (sudo, jq, ...)

### Requirements
 - zabbix 4.0 or newer
 - jq installed on the monitored device
