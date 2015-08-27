# NOTICE:
#
# Application name defined in TARGET has a corresponding QML filename.
# If name defined in TARGET is changed, the following needs to be done
# to match new name:
#   - corresponding QML filename must be changed
#   - desktop icon filename must be changed
#   - desktop filename must be changed
#   - icon definition filename in desktop file must be changed
#   - translation filenames have to be changed

# The name of your application
TARGET = sailfish-browser-search-engine-manager

CONFIG += sailfishapp

SOURCES += \
    src/fileutils.cpp \
    src/sailfish-browser-search-engine-manager.cpp

HEADERS += src/fileutils.h

OTHER_FILES += qml/sailfish-browser-search-engine-manager.qml \
    qml/cover/CoverPage.qml \
    qml/pages/FirstPage.qml \
    qml/pages/SecondPage.qml \
    rpm/sailfish-browser-search-engine-manager.changes.in \
    rpm/sailfish-browser-search-engine-manager.spec \
    rpm/sailfish-browser-search-engine-manager.yaml \
    translations/*.ts \
    sailfish-browser-search-engine-manager.desktop \
    qml/js/*.js \
    LICENSE

# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n

# German translation is enabled as an example. If you aren't
# planning to localize your app, remember to comment out the
# following TRANSLATIONS line. And also do not forget to
# modify the localized app name in the the .desktop file.
TRANSLATIONS += translations/sailfish-browser-search-engine-manager-de.ts
