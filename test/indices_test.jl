using Test, SudokuSolver

const SS = SudokuSolver

@testset "Indices" begin
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

    @testset "Indices inside grid" begin
        @test SS.ix_block(1, 1) == [1,2,3,10,11,12,19,20,21]
        @test SS.ix_block(1, 2) == [1,2,3,10,11,12,19,20,21]
        @test SS.ix_block(1, 3) == [1,2,3,10,11,12,19,20,21]
        @test SS.ix_block(3, 1) == [1,2,3,10,11,12,19,20,21]
        @test SS.ix_block(3, 3) == [1,2,3,10,11,12,19,20,21]

        @test SS.ix_block(4, 5) == [40,41,42,49,50,51,58,59,60]
    end
end
