# work related
if $WORK_ENV
    abbr -a rn 'run-it'
    abbr -a doceng 'cd /srv/documentengine'
    abbr -a serv 'anevis-services'

    alias mongodocker='mongosh --port 17027 -u root -p password --authenticationDatabase admin uat'
    alias pgtop='sudo -u postgres pg_top'
    alias print-mq='sudo /opt/apache/activemq/bin/activemq dstat queues | tail -n +14'
end
