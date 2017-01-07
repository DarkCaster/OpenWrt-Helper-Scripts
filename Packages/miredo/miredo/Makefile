#
# Copyright (C) 2006-2012 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=miredo
PKG_VERSION:=1.2.6.git.2014.08.13
PKG_RELEASE=$(PKG_SOURCE_VERSION)

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=http://git.remlab.net/git/miredo.git
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_VERSION:=6eb5e5a417667d47dfca31f80d5f3debbc4c4e0e
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION)-$(PKG_SOURCE_VERSION).tar.bz2

PKG_FIXUP:=autoreconf
PKG_FIXUP:=patch-libtool
PKG_FIXUP:=gettext-version
PKG_INSTALL:=1

include $(INCLUDE_DIR)/uclibc++.mk
include $(INCLUDE_DIR)/package.mk

define Package/miredo/Default
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=miredo: Teredo (IPv6 tunneling over UDP through NAT)
  URL:=http://www.remlab.net/miredo/
endef

define Package/miredo-common
$(call Package/miredo/Default)
  TITLE:=Teredo (IPv6 tunneling over UDP through NAT) shared libraries
  DEPENDS+= +ip +libpthread +librt $(CXX_DEPENDS) +kmod-ipv6 +kmod-tun
endef

define Package/miredo-server
$(call Package/miredo/Default)
  TITLE:=Teredo (IPv6 tunneling over UDP through NAT) server daemon
  DEPENDS+= +miredo-common
endef

define Package/miredo-server/conffiles
/etc/miredo/miredo-server.conf
endef

define Package/miredo-client
$(call Package/miredo/Default)
  TITLE:=Teredo (IPv6 tunneling over UDP through NAT) client and relay daemon
  DEPENDS+= +miredo-common
endef

define Package/miredo-client/conffiles
/etc/miredo/miredo.conf
/etc/miredo/miredo-watchdog.conf
endef

CONFIGURE_ARGS += \
	--enable-shared \
	--enable-static \
	--with-gnu-ld \
	--disable-rpath \
	--enable-teredo-client \
	--enable-miredo-user=root \
	--without-Judy

EXTRA_CXXFLAGS=-fno-rtti

CONFIGURE_VARS += \
	LIBS="-lm" \
	ac_cv_file__proc_self_maps=yes \
	ac_cv_header_sys_capability_h=no

MAKE_FLAGS := CXXLINK="$(TARGET_CXX)"

define Package/miredo-common/install
	$(INSTALL_DIR) $(1)/usr/lib
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/lib/lib{teredo,tun6}.so.* $(1)/usr/lib/
	$(INSTALL_DIR) $(1)/usr/lib/miredo
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/lib/miredo/miredo-privproc $(1)/usr/lib/miredo
endef

define Package/miredo-server/install
	$(INSTALL_DIR) $(1)/etc/miredo
	$(CP) $(PKG_INSTALL_DIR)/usr/share/doc/miredo/examples/miredo-server.conf $(1)/etc/miredo/miredo-server.conf
	$(INSTALL_BIN) ./files/client-hook $(1)/etc/miredo/
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/miredo-server.init $(1)/etc/init.d/miredo-server
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/sbin/miredo-server $(1)/usr/sbin/
endef

define Package/miredo-client/install
	$(INSTALL_DIR) $(1)/etc/miredo
	$(CP) $(PKG_INSTALL_DIR)/usr/share/doc/miredo/examples/miredo.conf $(1)/etc/miredo/miredo.conf
	$(INSTALL_BIN) ./files/client-hook $(1)/etc/miredo/
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/miredo.init $(1)/etc/init.d/miredo-client
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/sbin/miredo $(1)/usr/sbin/
	$(INSTALL_BIN) ./files/miredo-watchdog.sh $(1)/usr/sbin/
	$(CP) ./files/miredo-watchdog.conf $(1)/etc/miredo/miredo-watchdog.conf
endef

define Build/Prepare
	$(Build/Prepare/Default)
	( cd $(PKG_BUILD_DIR) && cp $(STAGING_DIR)/../host/share/gettext/gettext.h ./include/gettext.h )
endef

$(eval $(call BuildPackage,miredo-common))
$(eval $(call BuildPackage,miredo-server))
$(eval $(call BuildPackage,miredo-client))
