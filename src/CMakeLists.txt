set(SRC main.cpp)

qt_add_resources(RESOURCES qml/glacier-calc.qrc)

add_executable(glacier-calc ${SRC} ${RESOURCES})
target_link_libraries(glacier-calc
	Qt${QT_VERSION_MAJOR}::Core
	Qt${QT_VERSION_MAJOR}::Gui
	Glacier::App)
install(TARGETS glacier-calc RUNTIME
	DESTINATION ${CMAKE_INSTALL_BINDIR})
