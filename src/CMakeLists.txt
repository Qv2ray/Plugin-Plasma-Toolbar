# TODO: adapt "org.kde.plasma" here & elsewhere if needed (see README)
add_definitions(-DTRANSLATION_DOMAIN=\"org.qv2ray.qv2ray_plasmatoolbar\")

set(qv2ray_plugin_plasmatoolbar_SRCS
    qv2ray_plugin_plasmatoolbar.cpp
)

add_library(qv2ray_plasmatoolbar_libs MODULE ${qv2ray_plugin_plasmatoolbar_SRCS})

kcoreaddons_desktop_to_json(qv2ray_plasmatoolbar_libs package/metadata.desktop SERVICE_TYPES plasma-applet.desktop)

target_link_libraries(qv2ray_plasmatoolbar_libs
                      Qt5::Gui
                      Qt5::Network
                      Qt5::Core
                      KF5::Plasma
                      KF5::I18n)


install(TARGETS qv2ray_plasmatoolbar_libs DESTINATION ${KDE_INSTALL_PLUGINDIR}/plasma/applets)

plasma_install_package(package org.qv2ray.qv2ray_plasmatoolbar)
