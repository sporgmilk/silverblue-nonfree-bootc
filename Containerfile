FROM quay.io/fedora/fedora-silverblue:44

RUN dnf -y install \
        https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-44.noarch.rpm \
        https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-44.noarch.rpm; \
        dnf -y swap ffmpeg-free ffmpeg --allowerasing;\
        dnf -y group install multimedia \
            --setopt=install_weak_deps=False \
            --exclude=PackageKit-gstreamer-plugin \
            --allowerasing; \
    dnf -y install curl cabextract xorg-x11-font-utils fontconfig; \
    rpm -ivh --nodigest --nofiledigest https://downloads.sourceforge.net/project/mscorefonts2/rpms/msttcore-fonts-installer-2.6-1.noarch.rpm; \
    dnf -y config-manager addrepo --from-repofile=https://dl.winehq.org/wine-builds/fedora/44/winehq.repo; \
    dnf -y install openh264 intel-media-driver winehq-staging loupe chromium btop ntsync-autoload flatpak-spawn; \
    dnf -y remove gnome-software firefox fedora-third-party; \
    dnf clean all; \
    rm -rf \
        /var/cache/swcatalog \
        /var/cache/dnf \
        /var/cache/ibus \
        /var/cache/ldconfig \
        /var/cache/libdnf5 \
        /var/lib/dnf \
        /run/dnf\
        /tmp/.wget-hpkp_lck_0\
        /tmp/.wget-hsts_lck_0\
        /var/log/dnf5.log*

RUN bootc container lint

