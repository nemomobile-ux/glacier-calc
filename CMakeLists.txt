cmake_minimum_required(VERSION 3.1.0)

project(glacier-calc
	VERSION 0.3.1
	DESCRIPTION "The Glacier calculator")

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

include(FeatureSummary)
include(GNUInstallDirs)

set(QT_MIN_VERSION "5.11.0")
find_package(Qt5 COMPONENTS Core Gui Quick LinguistTools REQUIRED)
find_package(Glacier 0.8 COMPONENTS App REQUIRED)
find_package(Qt5QuickCompiler)

add_subdirectory(src)

install(FILES glacier-calc.desktop
	DESTINATION ${CMAKE_INSTALL_DATAROOTDIR}/applications/)
install(FILES icon-app-calculator.png
	DESTINATION ${CMAKE_INSTALL_DATAROOTDIR}/glacier-calc/images/)

# Translations
file(GLOB TS_FILES translations/*.ts)
qt5_add_translation(QM_FILES ${TS_FILES})
add_custom_target(translations DEPENDS ${QM_FILES})
add_dependencies(glacier-calc translations)

install(FILES ${QM_FILES}
        DESTINATION ${CMAKE_INSTALL_DATAROOTDIR}/glacier-calc/translations)
