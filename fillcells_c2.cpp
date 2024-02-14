// fillcells_c2.h
#include "fillcells.h"
#include <catch2/catch_all.hpp>

TEST_CASE("full fill")
{
    for (int numcells = 0; numcells < 16; numcells++) {
        Cells full = initial_cells(numcells, 1.0);
        for (bool state: full)
            REQUIRE(state == alive);
    }
}

TEST_CASE("empty fill")
{
    for (int numcells = 0; numcells < 16; numcells++) {
        Cells empty = initial_cells(numcells, 0.0);
        for (bool state: empty)
            REQUIRE(state == dead);
    }
}

TEST_CASE("half fill")
{
    for (int numcells = 0; numcells < 16; numcells+=2) {
        Cells half = initial_cells(numcells, 0.5);
        for (int i=0; i<numcells; i++) {
            if (i%2==1)
                REQUIRE(half[i] == alive);
            else
                REQUIRE(half[i] == dead);
        }
    }
}

TEST_CASE("quarter fill")
{
    for (int numcells = 0; numcells < 16; numcells+=4) {
        Cells quarter = initial_cells(numcells, 0.25);
        for (int i=0; i<numcells; i++) {
            if (i%4==3)
                REQUIRE(quarter[i] == alive);
            else
                REQUIRE(quarter[i] == dead);
        }
    }
}

TEST_CASE("partial fill")
{
    for (int numcells = 0; numcells < 16; numcells++) {
        Cells partial = initial_cells(numcells, 0.15);
        int sum = 0;
        for (bool s: partial) 
            if (s) sum++;
        REQUIRE(sum == int(0.15*numcells));
    }
}
