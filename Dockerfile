FROM centos:7

RUN yum -y update && \
    yum -y groupinstall "Development Tools" && \
    yum -y install libxml2-devel boost-devel openssl-devel rpmdevtools && \
    rpmdev-setuptree && \
    git clone https://github.com/adaptivecomputing/torque.git --depth=1 -b 6.1.1 /tmp/torque-6.1.1 && \
    cd /tmp/torque-6.1.1 && \
    ./autogen.sh && \
    cd /tmp && \
    tar caf /root/rpmbuild/SOURCES/torque-6.1.1.tar.gz torque-6.1.1 && \
    cd /tmp/torque-6.1.1 && \
    ./configure && \
    cp /tmp/torque-6.1.1/torque.spec /root/rpmbuild/SPECS/ && \
    echo '%define _unpackaged_files_terminate_build 0' >> /root/rpmbuild/SPECS/torque.spec && \
    yum -y clean all && \
    rm -rf /tmp/torque-6.1.1

CMD rpmbuild -bb /root/rpmbuild/SPECS/torque.spec
