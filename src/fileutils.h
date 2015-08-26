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

signals:

public slots:

};

#endif // FILEUTILS_H
