#include "updatecells.h"
#include <catch2/catch_all.hpp>

// A test to see that a state with all cells alive remains the same.
TEST_CASE("staying alive") {
    Cells cells_in {alive,alive,alive,alive};
    Cells cells_out = update_all_cells(cells_in);
    for (bool x: cells_in)
        REQUIRE(x==alive);
}

// A test to see that a state with all cells alive remains the same.
TEST_CASE("staying dead") {
    Cells cells_in {dead,dead,dead,dead};
    Cells cells_out = update_all_cells(cells_in);
    for (bool x: cells_in)
        REQUIRE(x==dead);
}

// One more interesting case.
// A test to see that a state with all cells alive remains the same.
TEST_CASE("more interesting") {
    Cells cells_in
        {dead, dead, alive, dead, dead, dead,alive, dead,alive,alive,alive};
    // use the rules in gameof1d.cpp which give: 
    Cells expected_cells_out
        {alive,alive, dead, dead,alive, dead, dead,alive, dead,alive,alive};
    Cells cells_out = update_all_cells(cells_in);
    // check it is correct
    for (int i = 0; i < 11; i++)
        REQUIRE(expected_cells_out[i] == cells_out[i]);
}
