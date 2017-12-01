QT += qml quick

TEMPLATE = app
TARGET = glacier-calc

SOURCES += src/main.cpp

OTHER_FILES += \
    src/qml/calculator.js \
    src/qml/main.qml \
    src/qml/Display.qml \
    src/qml/CalcButton.qml \
    src/qml/HistoryDisplay.qml \
    icon-app-calculator.png


target.path = /usr/bin
INSTALLS += target

desktop.path = /usr/share/applications
desktop.files = glacier-calc.desktop
INSTALLS += desktop

qml.path = /usr/share/glacier-calc/qml
qml.files = src/qml/*
INSTALLS += qml

icon.files = icon-app-calculator.png
icon.path = /usr/share/glacier-calc/images
INSTALLS += icon

DISTFILES += \
    rpm/glacier-calc.spec
