module("luci.controller.admin.wifiuplink", package.seeall)

function index()
	entry({"admin", "wifiuplink"}, cbi("admin/wifiuplink"), _("WLAN Uplink"), 10)
end
