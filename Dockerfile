FROM archlinux/base

VOLUME /repo

# Add PKGBUILDs
COPY ./pkg /pkg

# Add build script
COPY ./build_packages.sh /build_packages.sh

# Append lcnlt repository location to pacman.conf
RUN printf "[lnclt]\nSigLevel = Optional TrustAll\nServer = https://arch.lnc.lt/repo" >> /etc/pacman.conf

# Update Arch & install dependencies
RUN pacman -Syu --noconfirm base-devel wget sudo

# Add builduser with passwordless sudo rights
RUN useradd builduser -m \
 && passwd -d builduser \
 && printf "builduser ALL=(ALL) ALL\n" | tee -a /etc/sudoers \
 && chown -R builduser {/repo,/pkg}

USER builduser

# Install aurutils
RUN cd /tmp \
 && gpg --recv-key 6BC26A17B9B7018A \
 && wget "https://aur.archlinux.org/cgit/aur.git/snapshot/aurutils.tar.gz" \
 && tar -xf aurutils.tar.gz \
 && cd aurutils \
 && makepkg -sci --noconfirm

# Build packages and add to repository file
CMD bash build_packages.sh
