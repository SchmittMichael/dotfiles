# work related
if string match -rq '^anevis-admin:' </etc/passwd
  alias rn='run-it'
  alias mongodocker='mongosh --port 17027 -u root -p password --authenticationDatabase admin uat'
  alias serv='anevis-services'
  alias pgtop='sudo -u postgres pg_top'
  alias doceng='cd /srv/documentengine'
  alias print-mq='sudo /opt/apache/activemq/bin/activemq dstat queues | tail -n +14'
end
