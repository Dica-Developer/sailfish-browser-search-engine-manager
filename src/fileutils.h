/*
 Copyright (C) 2015 Dica-Developer.
 Contact: team@dica-developer.org
 All rights reserved.

 This file is part of sailfish-browser-search-engine-manager.

 sailfish-browser-search-engine-manager is free software: you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation, either version 3 of the License, or
 (at your option) any later version.

 sailfish-browser-search-engine-manager is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.

 You should have received a copy of the GNU General Public License
 along with sailfish-browser-search-engine-manager.  If not, see <http://www.gnu.org/licenses/>.
*/

#ifndef FILEUTILS_H
#define FILEUTILS_H

#include <QObject>
#include <QtCore/QStringList>

class FileUtils : public QObject
{
    Q_OBJECT
public:
    explicit FileUtils(QObject *parent = 0);

    Q_INVOKABLE static bool exists(QString fileName);
    Q_INVOKABLE static bool save(QString content, QString fileName);
    Q_INVOKABLE static bool unlink(QString fileName);
    Q_INVOKABLE static bool mkPath(QString filePath);
    Q_INVOKABLE static QStringList find(QString filePath, QString fileNamePattern);
    Q_INVOKABLE static QString read(QString fileName);
    Q_INVOKABLE static QString getHomeDir();

signals:

public slots:

};

#endif // FILEUTILS_H
