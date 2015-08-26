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
