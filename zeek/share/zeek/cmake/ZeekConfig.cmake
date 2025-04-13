
####### Expanded from @PACKAGE_INIT@ by configure_package_config_file() #######
####### Any changes to this file will be overwritten by the next CMake run ####
####### The input file was ZeekConfig.cmake.in                            ########

get_filename_component(PACKAGE_PREFIX_DIR "${CMAKE_CURRENT_LIST_DIR}/../../../" ABSOLUTE)

macro(set_and_check _var _file)
  set(${_var} "${_file}")
  if(NOT EXISTS "${_file}")
    message(FATAL_ERROR "File or directory ${_file} referenced by variable ${_var} does not exist !")
  endif()
endmacro()

macro(check_required_components _NAME)
  foreach(comp ${${_NAME}_FIND_COMPONENTS})
    if(NOT ${_NAME}_${comp}_FOUND)
      if(${_NAME}_FIND_REQUIRED_${comp})
        set(${_NAME}_FOUND FALSE)
      endif()
    endif()
  endforeach()
endmacro()

####################################################################################

include(CMakeFindDependencyMacro)

# Note: ZeekPluginConfig only exists on the build interface to pull in
#       additional variables and dependencies for building dynamic plugins.
if ( EXISTS "${CMAKE_CURRENT_LIST_DIR}/ZeekPluginConfig.cmake" )
    include("${CMAKE_CURRENT_LIST_DIR}/ZeekPluginConfig.cmake")
endif ()

set(CMAKE_THREAD_PREFER_PTHREAD ON)
set(THREADS_PREFER_PTHREAD_FLAG ON)
find_dependency(Threads REQUIRED)

# Find OpenSSL and Forward hints from Zeek's build config.
set(ZeekOpenSSLHint "")
if (ZeekOpenSSLHint AND NOT OPENSSL_ROOT_DIR)
    set(OPENSSL_ROOT_DIR "${ZeekOpenSSLHint}" CACHE
        PATH "Directory hint for finding OpenSSL" FORCE)
endif ()
find_dependency(OpenSSL REQUIRED)

# In our MSVC build, we have these extra dependencies from Conan.
if ( MSVC )
    find_dependency(libpcap)
    find_dependency(ZLIB)
    find_dependency(c-ares)
endif ()

if ( NOT "ON" )
    # Always force using the package config file since users might still have
    # a legacy FindBroker.cmake in their system.
    find_dependency(Broker REQUIRED CONFIG)
endif ()

foreach ( dep  )
  find_dependency(${dep} REQUIRED)
endforeach (  )

include("${CMAKE_CURRENT_LIST_DIR}/ZeekTargets.cmake")
