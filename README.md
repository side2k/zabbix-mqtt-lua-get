# zabbix-mqtt-lua-get

Simple Lua script for getting values for Zabbix data items from MQTT server.
At first, I've created simple Python script for this(see https://github.com/side2k/zabbix-mqtt-get).
But it seems Python is to heavy for simple scripts to be run on Raspberry Pi2, which I use to host MQTT server for my "smart home" network.
So here's Lua version. 

Dependencies: [luamqttc](https://github.com/Yongke/luamqttc) library, which can be installed simply by typing(either prepended with `sudo` for global install or appended by `--local` for local install):

```bash
luarocks install luamqttc
```

Usage example:
```bash
./mqtt_get.lua -h raspi -t /# -v
```

Check `--help` command line option(or sources) to get more info.
