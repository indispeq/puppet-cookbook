#!/bin/sh

sudo puppet apply /root/puppet/manifests/site.pp --modulepath=/root/puppet/modules/ $*

