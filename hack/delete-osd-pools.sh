ceph osd pool ls | grep objectstore.rgw | awk '{print $1}'| xargs -l bash -c 'ceph osd pool delete $0 $0 --yes-i-really-really-mean-it'
