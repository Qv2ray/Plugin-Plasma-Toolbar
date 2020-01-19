/*
 *   This program is free software; you can redistribute it and/or modify
 *   it under the terms of the GNU Library General Public License as
 *   published by the Free Software Foundation; either version 2, or
 *   (at your option) any later version.
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU General Public License for more details
 *
 *   You should have received a copy of the GNU Library General Public
 *   License along with this program; if not, write to the
 *   Free Software Foundation, Inc.,
 *   51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 */

#include "qv2ray_plugin_plasmatoolbar.h"
#include <klocalizedstring.h>
#include <stdio.h>
#include <iostream>

Qv2ray_Plugin_PlasmaToolbar::Qv2ray_Plugin_PlasmaToolbar(QObject *parent, const QVariantList &args) : Plasma::Applet(parent, args)
{
    //
    socket = new QLocalSocket();
    socket->connectToServer("Qv2ray_NetSpeed_Widget_LocalSocket");
}

QString Qv2ray_Plugin_PlasmaToolbar::readDataFromLocalSocket() const
{
    if(socket->state() == QLocalSocket::LocalSocketState::ConnectedState) {
        socket->write(QString("OK").toUtf8());
        socket->flush();
        auto str = QString::fromUtf8(socket->readAll());
        return str;
    } 
    else
    {
        socket->waitForConnected(5000);
        socket->connectToServer("Qv2ray_NetSpeed_Widget_LocalSocket");
        return "{\"Pages\":[ { \"Lines\": [{\"Message\": \"Disconnected\"}] }]}";
    }
}

K_EXPORT_PLASMA_APPLET_WITH_JSON(qv2ray_plugin_plasmatoolbar, Qv2ray_Plugin_PlasmaToolbar, "metadata.json")

#include "qv2ray_plugin_plasmatoolbar.moc"
