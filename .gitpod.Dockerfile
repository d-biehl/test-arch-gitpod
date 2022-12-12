FROM	 archlinux:latest

# Update the repositories
RUN	 pacman -Syy

RUN /bin/sh -c echo '[multilib]' >> /etc/pacman.conf && \     
    pacman --noconfirm -Syyu && \
    pacman --noconfirm -S base-devel git && \
    useradd -m -r -s /bin/bash aur && \
    passwd -d aur && \
    echo 'aur ALL=(ALL) ALL' > /etc/sudoers.d/aur && \
    mkdir -p /home/aur/.gnupg && \
    echo 'standard-resolver' > /home/aur/.gnupg/dirmngr.conf && \
    chown -R aur:aur /home/aur && \
    mkdir /build && \
    chown -R aur:aur /build && \
    cd /build && \
    sudo -u aur git clone --depth 1 https://aur.archlinux.org/yay.git && \
    cd yay && \
    sudo -u aur makepkg --noconfirm -si && \
    sudo -u aur yay --afterclean --removemake --save && \
    pacman -Qtdq | xargs -r pacman --noconfirm -Rcns && \
    rm -rf /home/aur/.cache && \
    rm -rf /build

RUN yay -S --noconfirm zsh oh-my-posh
RUN echo 'export POSH_THEME=/usr/share/oh-my-posh/themes/stelbent.minimal.omp.json' >> ~/.zshrc
RUN echo 'eval "$(oh-my-posh init zsh)"' >> ~/.zshrc

ENV SHELL=/usr/bin/zsh


