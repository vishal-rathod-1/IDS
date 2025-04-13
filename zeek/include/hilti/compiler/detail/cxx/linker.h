// Copyright (c) 2020-2023 by the Zeek Project. See LICENSE for details.

#pragma once

#include <map>
#include <memory>
#include <optional>
#include <set>
#include <string>
#include <utility>
#include <vector>

#include <hilti/base/result.h>
#include <hilti/compiler/detail/codegen/codegen.h>
#include <hilti/compiler/detail/cxx/unit.h>

namespace hilti::detail::cxx {

/**
 * HILTI's linker.
 *
 * It's not *really* a linker, it's a component that adds additional C++ code
 * requires knowledge across all compilation units.
 */
class Linker {
public:
    Linker(CodeGen* cg) : _codegen(cg) {}

    void add(const linker::MetaData& md);
    void finalize();
    Result<std::shared_ptr<cxx::Unit>> linkerUnit(); // only after finalize and at least one module

private:
    CodeGen* _codegen;
    std::shared_ptr<cxx::Unit> _linker_unit;

    std::set<std::pair<std::string, std::string>> _modules;
    std::map<std::string, std::vector<cxx::linker::Join>> _joins;
    std::set<cxx::declaration::Constant> _globals;
};

} // namespace hilti::detail::cxx
