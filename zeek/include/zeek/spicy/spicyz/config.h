// See the file "COPYING" in the main distribution directory for copyright.

#pragma once

#include <string>

#include <hilti/rt/filesystem.h>

#include "zeek/zeek-config-paths.h"

namespace zeek::spicy::configuration {

using path = hilti::rt::filesystem::path;

namespace {

// This mimics zeek-config to get the Zeek include directories.
static inline void add_path(std::string& old_path, const path& new_path) {
    if ( new_path.empty() )
        return;

    if ( ! old_path.empty() )
        old_path += ":";

    old_path += new_path.native();
}
} // namespace

static path get_env_path_or(const char* name, const char* default_) {
    assert(std::strlen(default_) != 0);
    if ( auto p = hilti::rt::getenv(name); p && ! p->empty() )
        return path(*p);
    else
        return default_;
}

inline const auto InstallBinDir() { return path("/opt/zeek") / "bin"; }

inline const auto LibraryPath() { return get_env_path_or("ZEEK_SPICY_LIBRARY_PATH", "/opt/zeek/share/zeek/spicy"); }

inline const auto ModulePath() { return get_env_path_or("ZEEK_SPICY_MODULE_PATH", "/opt/zeek/lib/zeek/spicy"); }

inline const auto DataPath() { return get_env_path_or("ZEEK_SPICY_DATA_PATH", "/opt/zeek/share/zeek"); }

inline const auto CxxZeekIncludesDirectories() {
    std::string includes;
    add_path(includes, path("/opt/zeek") / "include");

    // When changing any of the following, also update "zeek-config.in".
    add_path(includes, "/usr/include");
    add_path(includes, "/usr/include");
    add_path(includes, "/usr/include");
    add_path(includes, "");
    add_path(includes, "");

    return includes;
}

// Version of Spicy that we are compiling against.
#define SPICY_VERSION_NUMBER 11200

inline const auto InstallPrefix = path("/opt/zeek");

} // namespace zeek::spicy::configuration
