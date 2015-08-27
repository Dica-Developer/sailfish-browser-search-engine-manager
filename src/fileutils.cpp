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

#include "fileutils.h"

#include <QtQml>
#include <QtCore/QFile>
#include <QtCore/QDir>

FileUtils::FileUtils(QObject *parent) :
    QObject(parent)
{
}

bool FileUtils::exists(QString fileName) {
    QFile test(fileName);
    return test.exists(fileName);
}

bool FileUtils::save(QString content, QString fileName) {
    bool result = false;

    QFile fileForWriting(fileName);
    if (fileForWriting.open(QIODevice::WriteOnly | QIODevice::Truncate | QIODevice::Text)) {
        fileForWriting.write(content.toUtf8());
        fileForWriting.close();
        result = true;
    }

    return result;
}

bool FileUtils::unlink(QString fileName) {
    QFile fileForDeletion(fileName);
    return fileForDeletion.remove(fileName);
}

bool FileUtils::mkPath(QString filePath) {
    bool result = false;
    QDir test(filePath);
    if (!test.exists(filePath)) {
        result = test.mkpath(filePath);
    }
    return result;
}

QStringList FileUtils::find(QString filePath, QString fileNamePattern) {
    QStringList fileNamePatterns;
    fileNamePatterns.append(fileNamePattern);
    QDir filter(filePath);
    return filter.entryList(fileNamePatterns, QDir::Files, QDir::Name);
}

QString FileUtils::read(QString fileName) {
    QString result = NULL;

    QFile fileForReading(fileName);
    if (fileForReading.open(QIODevice::ReadOnly | QIODevice::Text)) {
        QByteArray content = fileForReading.readAll();
        result = result.fromUtf8(content);
        fileForReading.close();
    }

    return result;
}
