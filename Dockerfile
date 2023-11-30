FROM nvcr.io/nvidia/pytorch:23.10-py3

ENV NOTEBOOK_FOLDER=/workspace
COPY start_ssh.sh start_jupyterlab.sh entrypoint.sh /usr/local/bin/
COPY supervisord.conf /usr/local/etc/
COPY jupyter_server_config.py /root/.jupyter/

ARG JUPYTERLAB_VERSION=3.6.3
RUN pip install --upgrade pip \
    && pip install --no-cache-dir "supervisor" "jupyterlab==$JUPYTERLAB_VERSION"

RUN pip install monai[all] accelerate hydra-core wandb

ARG PASSWORD=ngc#1234
RUN echo "root:$PASSWORD" | chpasswd \
    && echo "Port 22" >> /etc/ssh/sshd_config \
    && echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config \
    && echo "PermitRootLogin yes" >> /etc/ssh/sshd_config \
    && echo "PATH=$PATH" > /etc/environment \
    && chmod +x /usr/local/bin/start_ssh.sh /usr/local/bin/start_jupyterlab.sh /usr/local/bin/entrypoint.sh \
    && mkdir /run/sshd 

RUN apt update && apt upgrade -y
RUN apt install git-lfs -y
COPY netrc /root/.netrc

WORKDIR ${NOTEBOOK_FOLDER}

RUN git config --global --add safe.directory "*"
RUN git config --global user.name "luisleo.nhri"
RUN git config --global user.email "luisleo526@yahoo.com"
RUN git config --global --unset https.proxy
RUN git config --global --unset http.proxy

EXPOSE 8888
EXPOSE 22

CMD ["entrypoint.sh"]

