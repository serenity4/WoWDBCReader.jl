using JSON3

schema_directory(model = "azerothcore") = joinpath(@__DIR__, "schemas", model)

schema_type(schema) = Symbol(uppercasefirst(string(schema)), :Data)

function datatype(type::String)
  type === "byte" && return :Int8
  type === "uint" && return :UInt32
  type === "int" && return :Int32
  type === "string" && return :String
  type === "float" && return :Float32
  type === "null" && return :Missing
  error("Unknown type '$type'")
end

function generate_schema_types()
  dest = joinpath(dirname(@__DIR__), "src", "schemas.jl")
  open(dest, "w+") do io
    types = Symbol[]
    println(io, "# This file was automatically generated with `generator/generate_schemas.jl`.\n")
    for file in readdir(schema_directory(); join = true)
      schema_name = first(splitext(basename(file)))
      name = schema_type(schema_name)
      push!(types, name)
      schema = JSON3.read(file)
      type = Expr(:struct, false, name)
      fields = Expr(:block)
      push!(type.args, fields)
      for field in schema
        push!(fields.args, Expr(:(::), Symbol(field.name), datatype(field.type)))
      end
      println(io, type)
      println(io)
    end
    println(io, '\n', Expr(:export, types...))
  end
end

generate_schema_types()
