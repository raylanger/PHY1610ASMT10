// outputcells.cpp
//
// see outputcells.h for documentation
//
// This code is part of assignment 3 of the 2024 Winter PHY1610 course.
//
// Ramses van Zon, 2024, University of Toronto
// 

#include "outputcells.h"

void output_cells(std::ostream& out, int step, const Cells& cell)
{
    int num_rows = cell.extent(0);
    int num_cols = cell.extent(1);
    const char on_char = 'I', off_char = '-';
    double alive_fraction = 0.0;
    for (auto& onecell: cell)
        if (onecell == alive)
            alive_fraction++;
    alive_fraction /= cell.size();
    out << step << "\t";
    for (int j = 0; j < num_cols; j++)
        if (cell[0][j] == alive)
            out << on_char;
        else
            out << off_char;
    out << " " << alive_fraction << "\n";
    for (int i = 1; i < num_rows; i++) {
        out << "\t";
        for (int j = 0; j < num_cols; j++)
            if (cell[i][j] == alive)
                out << on_char;
            else
                out << off_char;
        out << "\n";
    }
}

void output_alive_cells(std::ostream& out, int step, const Cells& cell)
{
    const bool* linearcells = cell.data();
    double alive_fraction = 0.0;
    for (long long i = 0; i < cell.size(); i++)
        alive_fraction += linearcells[i];
    rvector<int> alive_list(alive_fraction);
    int n = 0;
    for (long long i = 0; i < cell.size(); i++)
        if (linearcells[i] == alive) 
            alive_list[n++] = i;
    alive_fraction /= cell.size();
    out << step << "\t/";    
    for (const auto& x: alive_list)
        out << x << '/';
    out << "\t" << alive_fraction << "\n";
}
