cmake_minimum_required(VERSION 3.1.0)

project(glacier-calc
	VERSION 0.3.1
	DESCRIPTION "The Glacier calculator")

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

include(FeatureSummary)
include(GNUInstallDirs)

set(QT_MIN_VERSION "5.6.0")
find_package(Qt5 COMPONENTS Core Gui Quick REQUIRED)
find_package(Glacier COMPONENTS App REQUIRED)

add_subdirectory(src)

install(FILES glacier-calc.desktop
	DESTINATION ${CMAKE_INSTALL_DATAROOTDIR}/applications/)
install(FILES icon-app-calculator.png
	DESTINATION ${CMAKE_INSTALL_DATAROOTDIR}/glacier-calc/images/)
