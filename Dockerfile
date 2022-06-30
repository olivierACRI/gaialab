FROM registry.esa.int:5020/sepp/jl_base:v9.1915
ENV DEBIAN_FRONTEND noninteractive
COPY ./requirements.txt /tmp/
RUN apt-get update \
  && pip3 uninstall astropy -y \   
  && apt-get remove python3-pip python3.6 python3 python -y \
  && apt-get install python3.8=3.8.0-3ubuntu1~18.04.2 python3-pip=9.0.1-2.3~ubuntu1.18.04.5 -y \
  && pip3 install --no-cache-dir -r /tmp/requirements.txt \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

COPY *.ipynb /media/tutorials/
COPY *.png /media/tutorials/images/

COPY run.sh /opt/
RUN chmod +x /opt/run.sh

CMD   ["/sbin/tini", "--", "/opt/run.sh"]
