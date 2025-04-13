// Copyright (c) 2020-2023 by the Zeek Project. See LICENSE for details.

/**
 * This header defines functions that are made available to HILTI programs
 * inside the `hilti::*` namespace.
 */

#pragma once

#include <type_traits>

#include <hilti/rt/configuration.h>
#include <hilti/rt/exception.h>
#include <hilti/rt/extension-points.h>
#include <hilti/rt/util.h>

namespace hilti::rt {

/** Corresponds to `hilti::print`. */
template<typename T>
void print(const T& t, bool newline = true) {
    if ( ! configuration::get().cout )
        return;

    auto& cout = configuration::get().cout->get();

    cout << hilti::rt::to_string_for_print(t);

    if ( newline )
        cout << '\n';
    else
        cout.flush();
}

/** Corresponds to `hilti::printValues`. */
template<typename T, typename std::enable_if_t<is_tuple<T>::value>* = nullptr>
void printValues(const T& t, bool newline = true) {
    if ( ! configuration::get().cout )
        return;

    auto& cout = configuration::get().cout->get();

    cout << join_tuple_for_print(t);

    if ( newline )
        cout << '\n';
    else
        cout.flush();
}

// Just for testing: Declaring a function that's not implemented.
extern void __does_not_exist();

}; // namespace hilti::rt
