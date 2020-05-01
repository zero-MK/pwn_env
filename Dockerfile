FROM ubuntu:19.10

ENV DEBIAN_FRONTEND noninteractive


RUN echo "deb http://mirrors.ustc.edu.cn/ubuntu/ eoan main restricted universe multiverse\ndeb-src http://mirrors.ustc.edu.cn/ubuntu/ eoan main restricted universe multiverse\ndeb http://mirrors.ustc.edu.cn/ubuntu/ eoan-updates main restricted universe multiverse\ndeb-src http://mirrors.ustc.edu.cn/ubuntu/ eoan-updates main restricted universe multiverse\ndeb http://mirrors.ustc.edu.cn/ubuntu/ eoan-backports main restricted universe multiverse\ndeb-src http://mirrors.ustc.edu.cn/ubuntu/ eoan-backports main restricted universe multiverse\ndeb http://mirrors.ustc.edu.cn/ubuntu/ eoan-security main restricted universe multiverse\ndeb-src http://mirrors.ustc.edu.cn/ubuntu/ eoan-security main restricted universe multiverse\ndeb http://mirrors.ustc.edu.cn/ubuntu/ eoan-proposed main restricted universe multiverse\ndeb-src http://mirrors.ustc.edu.cn/ubuntu/ eoan-proposed main restricted universe multiverse" > /etc/apt/sources.list && \
    apt update && \
    apt install -y vim curl openssh-server wget ncat python2 python-pip python3 python3-pip gdb gcc libc6-dev libc6-i386 git tmux zsh sudo language-pack-zh-hans ltrace strace cmake && \
    apt clean && \
    localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
    
RUN mkdir ~/.pip && \
    echo "[global]\nindex-url = https://pypi.douban.com/simple/\n[install]\ntrusted-host = pypi.douban.com" >  ~/.pip/pip.conf && \
    pip3 install ROPgadget pwntools pycrypto ipython && \
    pip install pwntools
    
    
RUN git clone https://github.com/pwndbg/pwndbg ~/tools/pwndbg && \       
    git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh && \
    git clone https://github.com/longld/peda.git ~/tools/peda && \
    git clone https://github.com/radare/radare2.git ~/tools/radare2

RUN cd ~/tools/pwndbg && ./setup.sh && \
    echo "source ~/tools/peda/peda.py" >> ~/.gdbinit && \ 
    cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc && \       
    chsh -s /bin/zsh && \       
    sed -i 's/ZSH_THEME=\"robbyrussell\"/ZSH_THEME=\"ys\"/' ~/.zshrc && \
    sh ~/tools/radare2/sys/install.sh && \
    radare2 -v && \
    ln -s /usr/local/bin/radare2 /bin/r2 && \
    rm -rf /tools/radare2 && \
    apt-get clean && apt-get autoremove

RUN wget https://raw.githubusercontent.com/zero-MK/7th-vim/master/install.sh && bash install.sh -i && rm install.sh 

WORKDIR /root
