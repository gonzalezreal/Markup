#!/bin/sh
set -e

"${PROJECT_DIR}/Tools/swiftformat" --indent tabs --stripunusedargs closure-only --decimalgrouping 3,4 --commas inline --disable hoistPatternLet "${SRCROOT}/MarkupExample/" "${SRCROOT}/Sources/" "${SRCROOT}/Tests/"
