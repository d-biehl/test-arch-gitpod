FROM	 archlinux:latest

# Update the repositories
RUN	 pacman -Syy

RUN	 pacman -S --noconfirm base-devel
