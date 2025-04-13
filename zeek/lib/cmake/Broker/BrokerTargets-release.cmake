#----------------------------------------------------------------
# Generated CMake target import file for configuration "Release".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "broker_static" for configuration "Release"
set_property(TARGET broker_static APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(broker_static PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "C;CXX"
  IMPORTED_LOCATION_RELEASE "/opt/zeek/lib/libbroker.a"
  )

list(APPEND _IMPORT_CHECK_TARGETS broker_static )
list(APPEND _IMPORT_CHECK_FILES_FOR_broker_static "/opt/zeek/lib/libbroker.a" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
