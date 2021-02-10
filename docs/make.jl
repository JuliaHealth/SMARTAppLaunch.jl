using SMARTAppLaunch
using Documenter

makedocs(;
    modules=[SMARTAppLaunch],
    authors="Dilum Aluthge and contributors",
    repo="https://github.com/JuliaHealth/SMARTAppLaunch.jl/blob/{commit}{path}#L{line}",
    sitename="SMARTAppLaunch.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://JuliaHealth.github.io/SMARTAppLaunch.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/JuliaHealth/SMARTAppLaunch.jl",
)
