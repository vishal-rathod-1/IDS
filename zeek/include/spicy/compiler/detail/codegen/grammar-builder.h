// Copyright (c) 2020-2023 by the Zeek Project. See LICENSE for details.

#pragma once

#include <map>
#include <string>

#include <hilti/base/logger.h>
#include <hilti/base/result.h>
#include <hilti/compiler/context.h>

#include <spicy/ast/forward.h>
#include <spicy/compiler/detail/codegen/grammar.h>

namespace spicy::logging::debug {
inline const hilti::logging::DebugStream Grammar("grammar");
} // namespace spicy::logging::debug

namespace spicy::detail {

class CodeGen;

namespace codegen {

class Grammar;

/** Generates the grammars for all unit types declared in an AST. */
class GrammarBuilder {
public:
    GrammarBuilder(CodeGen* cg) : _cg(cg) {}

    CodeGen* cg() const { return _cg; }
    Builder* builder() const;
    ASTContext* context() const;
    const hilti::Options& options() const;

    /**
     * Generates the grammar for a unit type. The grammar will afterwards be
     * available through `grammar()`.
     */
    hilti::Result<hilti::Nothing> run(type::Unit* unit);

    /**
     * Returns the grammar for a unit type. The type's grammar must have been
     * computed through `run()` already, which is generally done for all AST
     * unit types at the beginning of code generation. If the grammar hasn't
     * been computed yet, this will return null.
     */
    const Grammar* grammar(const type::Unit& unit);

private:
    CodeGen* _cg;
    std::map<ID, Grammar> _grammars;
};

} // namespace codegen
} // namespace spicy::detail
