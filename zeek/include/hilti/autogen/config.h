// Copyright (c) 2020-2023 by the Zeek Project. See LICENSE for details.

#pragma once

#include <cstdint>
#include <optional>
#include <string>
#include <vector>

#include <hilti/rt/filesystem.h>

#define HAVE_TOOLCHAIN

#define CMAKE_DL_LIBS (std::string("dl").size() ? "dl" : "")
#define CMAKE_THREAD_LIBS_INIT (std::string("").size() ? "" : "")

namespace hilti {

/**
 * Stores compile-time configuration information.
 */
struct Configuration {
    /**
     * Default constructor that initializes all settings for execution from the
     * installation location. To change that, call `initLocation()`.
     */
    Configuration();

    /**
     * Reconfigures the configuration object to adapt all paths to
     * potentially running out of the build directory.
     *
     * @param use_build_directory true to adapt paths to build directory, false for installation directory
     */
    void initLocation(bool use_build_directory);

    /**
     * Reconfigures the configuration object to adapt all paths to
     * potentially running out of the build directory. This version bases the
     * decision on the path of the current executable: if it's inside the
     * source directory, we're assuming we're running out of build directory.
     *
     * @param argv0 path to current executable
     */
    void initLocation(const hilti::rt::filesystem::path& argv0);

    /**
     * Reconfigures the configuration object to adapt all paths to
     * potentially running out of the build directory. This version bases the
     * decision on the path of the current executable: if it's inside the
     * source directory, we're assuming we're running out of build directory.
     *
     * \note We need this overload as otherwise the boolean version
     * would be picked for C strings.
     *
     * @param argv0 path to current executable
     */
    void initLocation(const char* argv0);

    /**
     * Returns a hash of the current configuration. This only takes config values relevant for JIT into account.
     */
    std::size_t hash_for_jit() const;

    bool uses_build_directory; /**< True if all information pertains to running outside of the build directory. */

    std::string compiler_id;                                 /**< Identifier of the compiler */
    hilti::rt::filesystem::path cxx;                         /**< Full path to C++ compiler */
    std::optional<hilti::rt::filesystem::path> cxx_launcher; /**< Full path to C++ compiler launcher */
    hilti::rt::filesystem::path distbase;                    /**< base directory of HILTI source distribution */
    hilti::rt::filesystem::path hiltic;                      /**< Full path to `hiltic` binary */
    hilti::rt::filesystem::path install_prefix;              /**< HILTI install prefix */
    hilti::rt::filesystem::path lib_directory;   /**< Full path to directory where HILTI libraries are stored  */
    hilti::rt::filesystem::path build_directory; /**< Full path to directory where HILTI was built */
    std::vector<hilti::rt::filesystem::path>
        hilti_library_paths; /**< Default search path for HILTI modules, separated by `:` */

    std::vector<hilti::rt::filesystem::path>
        runtime_cxx_include_paths; /**< C++ include directories for runtime headers */
    std::vector<hilti::rt::filesystem::path> runtime_cxx_library_paths; /**< C++ library directories for runtime */
    std::vector<hilti::rt::filesystem::path>
        toolchain_cxx_include_paths; /**< C++ include directories for toolchain headers */
    std::vector<hilti::rt::filesystem::path> toolchain_cxx_library_paths; /**< C++ library directories for runtime */

    uint64_t version_number;         /**< Single version number encoding major/minor/patch levels */
    std::string version_string;      /* Readable version string, without git information */
    std::string version_string_long; /* Readable version string, including git information */

    std::vector<std::string> runtime_cxx_flags_debug;   /**< C++ compiler flags when compiling custom code in debug mode
                                                           that uses the HILTI runtime library */
    std::vector<std::string> runtime_ld_flags_debug;    /**< Linker flags when compiling custom code in debug mode that
                                                           uses the HILTI runtime library */
    std::vector<std::string> runtime_cxx_flags_release; /**< C++ compiler flags when compiling custom code in release
                                                           mode that uses the HILTI runtime library */
    std::vector<std::string> runtime_ld_flags_release; /**< Linker flags when compiling custom code in release mode that
                                                          uses the HILTI runtime library */

    std::vector<std::string>
        hlto_cxx_flags_debug; /**< C++ compiler flags when building a precompiled HLTO library in debug mode. */
    std::vector<std::string>
        hlto_ld_flags_debug; /**< Linker flags when when building a precompiled HLTO library in debug mode. */
    std::vector<std::string> hlto_cxx_flags_release; /**< C++ compiler flags when when building a precompiled HLTO
                                                        library in release mode. */
    std::vector<std::string>
        hlto_ld_flags_release; /**< Linker flags when when building a precompiled HLTO library in release mode. */

private:
    void init(bool use_build_directory);
};

/**
 * Returns a reference to the global configuration information. This is the
 * same information that `hilti-config` reports as well.
 */
extern Configuration& configuration();

} // namespace hilti
