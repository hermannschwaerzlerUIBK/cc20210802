FROM rockylinux/rockylinux:8
ENV container docker

# run container with "-v /sys/fs/cgroup:/sys/fs/cgroup:ro" for this to work!
# and add "-v /tmp/$(mktemp -d):/run" for Debian/Ubuntu (based) hosts
VOLUME [ "/sys/fs/cgroup" ]

CMD ["/usr/sbin/init"]

# as we need a working systemd we remove systemd unit-files that may cause problems:
RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == \
systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;

RUN dnf -y update
RUN dnf install -y wget passwd net-tools 
