# This script is installed alongside ZeekPlugin.cmake for passing variables from
# the CMake configuration step to plugins.

# Allows scripts such as ZeekPlugin.cmake to locate the Zeek CMake package.
set(ZEEK_CMAKE_CONFIG_DIR "/opt/zeek/share/zeek/cmake"
    CACHE PATH "Internal Zeek variable: the CMake package path for Zeek." FORCE)

# Tells ZeekPlugin.cmake where to install plugins.
set(ZEEK_PLUGIN_DIR "/opt/zeek/lib/zeek/plugins"
    CACHE PATH "Internal Zeek variable: the directory for installing Zeek plugins." FORCE)

# Allows scripts to locate files in the Zeek install tree.
set(ZEEK_CMAKE_INSTALL_PREFIX "/opt/zeek"
    CACHE PATH "Internal Zeek variable: CMAKE_INSTALL_PREFIX of Zeek." FORCE)

# Set ZEEK_PLUGIN_SCRIPTS_PATH for ZeekPlugin.cmake. We install the scripts into
# the package directory.
set(ZEEK_PLUGIN_SCRIPTS_PATH "${ZEEK_CMAKE_CONFIG_DIR}"
    CACHE PATH "Path to utility scripts for building Zeek plugins." FORCE)

# The CMAKE_BUILD_TYPE type to use for external plugins if not overridden.
set(ZEEK_CMAKE_BUILD_TYPE "Release"
    CACHE PATH "Internal Zeek variable: CMAKE_BUILD_TYPE of Zeek." FORCE)
