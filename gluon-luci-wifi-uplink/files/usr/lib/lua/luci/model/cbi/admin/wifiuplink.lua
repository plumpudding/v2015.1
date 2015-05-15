local f, s, o, ssid
local uci = luci.model.uci.cursor()

-- where to read the configuration from
local ssid = uci:get('wireless', 'uplink_radio0', "ssid")

f = SimpleForm("wifi", translate("WLAN Uplink"))
f.template = "admin/expertmode"

s = f:section(SimpleSection, nil, translate(
                'WLAN Uplink 1'
))

o = s:option(Flag, "enabled", translate("Enabled"))
o.default = (ssid and not uci:get_bool('wireless', primary_iface, "disabled")) and o.enabled or o.disabled
o.rmempty = false

o = s:option(Value, "ssid", translate("Name (SSID)"))
o:depends("enabled", '1')
o.default = ssid

--o = s:option(Value, "key", translate("Key"), translate("8-63 characters"))
--o:depends("enabled", '1')
--o.datatype = "wpakey"
--o.default = uci:get(config, primary_iface, "key")

function f.handle(self, state, data)
  if state == FORM_VALID then
    uci:foreach('wireless', "wifi-device",
      function(s)
        local device = s['.name']
        local name   = "uplink_" .. device

        if data.enabled == '1' then
          -- set up WAN wifi-iface
          uci:section('wireless', "wifi-iface", name,
                      {
                        device     = device,
                        ifname    = "br-wan",
                        network    = "uplink",
                        mode       = 'sta',
                        ssid       = data.ssid,
                        disabled   = 0,
                      }
          )
        else
          -- disable WAN wifi-iface
          uci:set('wireless', name, "disabled", 1)
        end
    end)

    uci:save(config)
    uci:commit(config)
  end
end

return f
