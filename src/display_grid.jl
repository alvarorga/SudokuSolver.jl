import Base.display

function Base.display(sudoku::Sudoku)
    g = sudoku.grid
    println(" --------------------------")
    for i=1:9
        print(" | $(display_number(g[i, 1])) $(display_number(g[i, 2])) $(display_number(g[i, 3])) ")
        print("| $(display_number(g[i, 4])) $(display_number(g[i, 5])) $(display_number(g[i, 6])) ")
        println(" | $(display_number(g[i, 7])) $(display_number(g[i, 8])) $(display_number(g[i, 9])) |")
        if i%3 == 0
            println(" --------------------------")
        end
    end
end

function display_number(n::Int)::String
    if n > 0
        return "$(n)"
    else
        return " "
    end
end
