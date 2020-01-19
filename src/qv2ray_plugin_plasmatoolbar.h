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

#ifndef QV2RAY_PLUGIN_PLASMATOOLBAR_H
#define QV2RAY_PLUGIN_PLASMATOOLBAR_H


#include <Plasma/Applet>
#include <QLocalSocket>
#include <QThread>

class Qv2ray_Plugin_PlasmaToolbar : public Plasma::Applet
{
    Q_OBJECT
    Q_PROPERTY(QString data READ readDataFromLocalSocket CONSTANT)

public:
    Qv2ray_Plugin_PlasmaToolbar( QObject *parent, const QVariantList &args );
    ~Qv2ray_Plugin_PlasmaToolbar() { };

    QString readDataFromLocalSocket() const;

private:
    QLocalSocket *socket;
};

#endif
