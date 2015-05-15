include $(TOPDIR)/rules.mk

PKG_NAME:=gluon-luci-wifi-uplink
PKG_VERSION:=1
PKG_RELEASE:=1

PKG_BUILD_DIR := $(BUILD_DIR)/$(PKG_NAME)

include $(GLUONDIR)/include/package.mk

PKG_CONFIG_DEPENDS += $(GLUON_I18N_CONFIG)

define Package/gluon-luci-wifi-uplink
  SECTION:=gluon
  CATEGORY:=Gluon
  DEPENDS:=+gluon-luci-admin
  TITLE:=Configure uplink from another WLAN network
endef

define Build/Prepare
	mkdir -p $(PKG_BUILD_DIR)
endef

define Build/Configure
endef

define Build/Compile
	$(call GluonBuildI18N,gluon-luci-wifi-uplink,i18n)
endef

define Package/gluon-luci-private-wifi/install
	$(CP) ./files/* $(1)/
	$(call GluonInstallI18N,gluon-luci-wifi-uplink,$(1))
endef

$(eval $(call BuildPackage,gluon-luci-wifi-uplink))
