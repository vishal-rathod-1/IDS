
####### Expanded from @PACKAGE_INIT@ by configure_package_config_file() #######
####### Any changes to this file will be overwritten by the next CMake run ####
####### The input file was BrokerConfig.cmake.in                            ########

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

set(CMAKE_THREAD_PREFER_PTHREAD ON)
set(THREADS_PREFER_PTHREAD_FLAG ON)
find_dependency(Threads REQUIRED)

find_dependency(OpenSSL REQUIRED)

set(BROKER_USE_EXTERNAL_CAF OFF)
if(BROKER_USE_EXTERNAL_CAF)
  find_dependency(CAF 0.18.5 REQUIRED COMPONENTS core io net)
endif()

include("${CMAKE_CURRENT_LIST_DIR}/BrokerTargets.cmake")

set(BROKER_LIBRARY "broker_static" CACHE INTERNAL "name of the Broker library target")

function(set_include_dir)
  get_target_property(dirs ${BROKER_LIBRARY} INTERFACE_INCLUDE_DIRECTORIES)
  set(BROKER_INCLUDE_DIR "${dirs}" CACHE INTERNAL "extra include directories")
endfunction()

set_include_dir()
