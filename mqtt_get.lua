#!/usr/bin/env lua

local mqttclient = require("luamqttc/client")
local get_opts = require("alt_getopt").get_opts
local timeout = 1

local long_opts = {
    verbose = "v",
    host = "h",
    topic = "t",
    help = "H",
    timeout = "T",
}

local default_opts = {
    t = "/#",
    h = "localhost",
    T = "0.1",
}

parsed_args = get_opts(arg, "Hvh:t:T:", long_opts)

if parsed_args.H then
    print([[
Lua MQTT subscribe script
Command line options:
    -h <host>, --host <host>
        (default: localhost)
    -t <topic>, --topic <topic>
        (default: /#)
    -T <timeout>, --timeout <timeout>
        timeout in seconds for data packet waiting. By default timeout
        is 0.1(100 msec), whichcould be too small if your network
        connection is very bad
    -v, --verbose
        print corresponding topic names

    ]])
    return
end

for k, v in pairs(default_opts) do
    if not parsed_args[k] then
        parsed_args[k] = v
    end
end

local client = mqttclient.new("lua_script")
client:connect(parsed_args.h, 1883, { timeout = timeout })

local callback = function(topic, data)
    if parsed_args.v then
        print(topic, data)
    else
        print(data)
    end
end

client:subscribe(parsed_args.t, 2, callback)
client:message_loop(tonumber(parsed_args.T))

client:disconnect()
