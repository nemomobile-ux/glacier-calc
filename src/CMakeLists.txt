set(SRC main.cpp)

qtquick_compiler_add_resources(RESOURCES qml/glacier-calc.qrc)

add_executable(glacier-calc ${SRC} ${RESOURCES})
target_link_libraries(glacier-calc
	Qt5::Core
	Qt5::Gui
	Glacier::App)
install(TARGETS glacier-calc RUNTIME
	DESTINATION ${CMAKE_INSTALL_BINDIR})
