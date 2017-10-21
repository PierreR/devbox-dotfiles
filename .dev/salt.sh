#!/usr/bin/env bash

set -ex

incl_confdir="/var/lib/salt/master.d"

psql -h localhost -U salt saltstack -f ./salt.sql

hostname=$(hostname)
salt-key -a "$hostname" -y

mkdir $incl_confdir
pushd $incl_confdir
cat > ./cirb.conf <<EOF
master_job_cache: pgjsonb

returner.pgjsonb.host: "localhost"
returner.pgjsonb.db: "saltstack"
returner.pgjsonb.user: "salt"
returner.pgjsonb.pass: "pepper"
EOF
popd

systemctl restart salt-master
