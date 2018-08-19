FROM archlinux/base

VOLUME /repo
COPY ./pkg /pkg

# Update Arch & install dependencies
COPY ./pacman.conf /etc/pacman.conf
RUN pacman -Syu --noconfirm base-devel wget sudo

# Add builduser with passwordless sudo rights
RUN useradd builduser -m \
 && passwd -d builduser \
 && printf "builduser ALL=(ALL) ALL\n" | tee -a /etc/sudoers \
 && chown -R builduser {/repo,/pkg,/tmp}

USER builduser

# Install aurutils
RUN cd /tmp \
 && gpg --recv-key 6BC26A17B9B7018A \
 && wget "https://aur.archlinux.org/cgit/aur.git/snapshot/aurutils.tar.gz" \
 && tar -xf aurutils.tar.gz \
 && cd aurutils \
 && makepkg -sci --noconfirm

# Build packages and add to repository file
COPY ./build_packages.sh /build_packages.sh
CMD bash build_packages.sh
