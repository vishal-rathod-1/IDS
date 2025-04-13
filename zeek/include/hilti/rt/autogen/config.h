// Copyright (c) 2020-2023 by the Zeek Project. See LICENSE for details.

#pragma once

#include <string>

#define HILTI_HAVE_BACKTRACE
#ifdef HILTI_HAVE_BACKTRACE
#include <execinfo.h>
#endif

// GCC uses __SANITIZE_ADDRESS__, Clang uses __has_feature.
#if defined(__SANITIZE_ADDRESS__)
#define HILTI_HAVE_ASAN
#endif

#if defined(__has_feature)
#if __has_feature(address_sanitizer)
#define HILTI_HAVE_ASAN
#endif
#endif
