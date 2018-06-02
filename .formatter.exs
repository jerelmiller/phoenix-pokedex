[
  inputs: ["mix.exs", "{config,lib,test}/**/*.{ex,exs}"],
  line_length: 80,
  locals_without_parens: [
    import_types: 1,
    resolve: 1,
    arg: :*,
    enum: 2,
    object: 2,
    value: 1,
    field: :*
  ]
]
