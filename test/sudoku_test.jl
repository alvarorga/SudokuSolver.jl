using Test, SudokuSolver

const SS = SudokuSolver

@testset "Sudoku structure" begin
    s1 = sampleSudoku(1)

    @testset "Index and grid positions" begin
        @test SS.g2ix(1, 1) == 1
        @test SS.g2ix(2, 1) == 2
        @test SS.g2ix(1, 2) == 10
        @test SS.g2ix(3, 4) == 30
        @test SS.g2ix(9, 4) == 36
        @test SS.g2ix(8, 9) == 80
        @test SS.g2ix(9, 9) == 81

        @test SS.ix2g(1) == (1, 1)
        @test SS.ix2g(2) == (2, 1)
        @test SS.ix2g(11) == (2, 2)
        @test SS.ix2g(18) == (9, 2)
        @test SS.ix2g(80) == (8, 9)
        @test SS.ix2g(81) == (9, 9)
    end

    @testset "Test candidates" begin
        @test s1.candidates[1] == 1<<3 + 1<<4
        @test s1.candidates[2] == 0
        @test s1.candidates[36] == 1<<3
        @test s1.candidates[38] == 1<<3 + 1<<6
        @test s1.candidates[81] == 1<<1 + 1<<3 + 1<<5 + 1<<6
    end
end
