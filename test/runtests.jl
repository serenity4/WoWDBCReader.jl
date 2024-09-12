using WoWDBCReader
using Test

dbc_file(name) = joinpath("/home/serenity4/Documents/programming/wow-local/node-dbc-reader/data/dbc", "$name.dbc")

@testset "WoWDBCReader.jl" begin
  @testset "Reading DBC files" begin
    dbc = read_dbc(dbc_file(:TalentTab), :talenttab)
    @test isa(dbc, Vector{TalenttabData})
    @test length(dbc) == 33

    dbc = read_dbc(dbc_file(:Talent), :talent)
    @test isa(dbc, Vector{TalentData})
    @test length(dbc) == 892

    dbc = read_dbc(dbc_file(:Map), :map)
    @test isa(dbc, Vector{MapData})
    @test length(dbc) == 135

    dbc = read_dbc(dbc_file(:Spell), :spell)
    @test isa(dbc, Vector{SpellData})
    @test length(dbc) > 49000
  end
end;


archive = WoWDBCReader.create_archive("test", 1024)
