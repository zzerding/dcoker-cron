## this is docke use cron example

## how to use
### base
`docker run --rm -v $PWD/crontab:/var/run/crontab zzerding/docker-cron`

### user scprit
`docker run --rm -v $PWD/crontab:/crontab -v $PWD/scprit:/var/run/scprit zzerding/docker-cron`
