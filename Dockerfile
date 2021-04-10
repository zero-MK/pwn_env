FROM ubuntu:20.04

RUN sed -i 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list && \
    ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    apt update && \
    apt install -y vim curl openssh-server wget ncat python2 python3 python2-dev python3-dev gdb gcc libc6-dev libc6-i386 git tmux zsh sudo ltrace strace cmake && \
    apt clean

RUN wget https://bootstrap.pypa.io/get-pip.py && python3 get-pip.py && rm get-pip.py && \
    wget https://bootstrap.pypa.io/pip/2.7/get-pip.py && /usr/bin/python2  get-pip.py && rm get-pip.py
    

RUN mkdir ~/.pip && \
    echo "[global]\nindex-url = https://pypi.douban.com/simple/\n[install]\ntrusted-host = pypi.douban.com" >  ~/.pip/pip.conf && \
    pip3 install ipython ROPgadget pwntools pycryptodome ipython z3-solver ropper keystone-engine && \
    pip2 install pwntools keystone-engine
    
    
RUN /usr/bin/git config --global url."https://hub.fastgit.org/".insteadOf "https://github.com/" && \
    /usr/bin/git config --global url."https://raw.fastgit.org/".insteadOf "https://raw.githubusercontent.com/"

RUN cd ~ && \
    git clone https://github.com/soaringk/gdb-peda-pwndbg-gef.git && \       
    git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh && \
    git clone https://github.com/radare/radare2.git ~/tools/radare2

RUN cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc && \       
    chsh -s /bin/zsh && \       
    sed -i 's/ZSH_THEME=\"robbyrussell\"/ZSH_THEME=\"ys\"/' ~/.zshrc && \
    bash ~/gdb-peda-pwndbg-gef/install.sh && \
    sh ~/tools/radare2/sys/install.sh && \
    radare2 -v && \
    ln -s /usr/local/bin/radare2 /bin/r2 && \
    rm -rf /tools/radare2 && \
    apt-get clean && apt-get autoremove

RUN curl -sLf https://spacevim.org/install.sh | bash

WORKDIR /root
