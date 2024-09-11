using WoWDBCReader
using Documenter

DocMeta.setdocmeta!(WoWDBCReader, :DocTestSetup, :(using WoWDBCReader); recursive=true)

makedocs(;
    modules=[WoWDBCReader],
    authors="Cédric BELMANT",
    sitename="WoWDBCReader.jl",
    format=Documenter.HTML(;
        canonical="https://serenity4.github.io/WoWDBCReader.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/serenity4/WoWDBCReader.jl",
    devbranch="main",
)
