using WoWDataParser
using Documenter

DocMeta.setdocmeta!(WoWDataParser, :DocTestSetup, :(using WoWDataParser); recursive=true)

makedocs(;
    modules=[WoWDataParser],
    authors="Cédric BELMANT",
    sitename="WoWDataParser.jl",
    format=Documenter.HTML(;
        canonical="https://serenity4.github.io/WoWDataParser.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/serenity4/WoWDataParser.jl",
    devbranch="main",
)
