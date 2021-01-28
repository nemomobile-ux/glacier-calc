set(SRC main.cpp)

add_executable(glacier-calc ${SRC})
target_link_libraries(glacier-calc
	Qt5::Core
	Qt5::Gui
	Glacier::App)
install(TARGETS glacier-calc RUNTIME
	DESTINATION ${CMAKE_INSTALL_BINDIR})
install(DIRECTORY qml
	DESTINATION ${CMAKE_INSTALL_DATAROOTDIR}/glacier-calc)
