FROM python:3.11.3-alpine
LABEL description="Docker image for hacomfoairmqtt and serial over IP"

ENV SOCAT="True"
ENV COMFOAIR_IP="192.168.1.50"
ENV COMFOAIR_PORT="502"
ENV SERIAL_PORT="/dev/comfoair"
ENV RS485_PROTOCOL="False"
ENV REFRESH_INTERVAL="10"
ENV ENABLE_PC_MODE="False"
ENV DEBUG="False"
ENV MQTT_SERVER="mosquitto.domain.tld"
ENV MQTT_PORT="1883"
ENV MQTT_KEEPALIVE="45"
ENV MQTT_USER="username"
ENV MQTT_PASSWORD="password"
ENV HA_ENABLE_AUTO_DISCOVERY_SENSORS="True"
ENV HA_ENABLE_AUTO_DISCOVERY_CLIMATE="True"
ENV HA_AUTO_DISCOVERY_DEVICE_ID="ca350"
ENV HA_AUTO_DISCOVERY_DEVICE_NAME="CA350"
ENV HA_AUTO_DISCOVERY_DEVICE_MANUFACTURER="Zehnder"
ENV HA_AUTO_DISCOVERY_DEVICE_MODEL="ComfoAir 350"
ENV DEVICE_FANOUT_ABSENT="15"
ENV DEVICE_FANOUT_LOW="35"
ENV DEVICE_FANOUT_MID="50"
ENV DEVICE_FANOUT_HIGH="70"
ENV DEVICE_FANIN_ABSENT="20"
ENV DEVICE_FANIN_LOW="40"
ENV DEVICE_FANIN_MID="55"
ENV DEVICE_FANIN_HIGH="75"

RUN pip install pyserial paho-mqtt PyYAML

RUN apk update
RUN apk add socat



RUN mkdir -p /opt/hacomfoairmqtt
COPY src/ca350.py /opt/hacomfoairmqtt/ca350.py
COPY src/config.ini.docker /opt/hacomfoairmqtt/config.ini.docker

COPY src/start.sh /usr/local/bin/start.sh
RUN chmod 755 /usr/local/bin/start.sh
CMD ["sh", "/usr/local/bin/start.sh"]
