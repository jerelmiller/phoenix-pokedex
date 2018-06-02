[
  inputs: ["mix.exs", "{config,lib,test}/**/*.{ex,exs}"],
  line_length: 80,
  locals_without_parens: [
    # Absinthe
    import_types: 1,
    resolve: 1,
    arg: :*,
    enum: 2,
    object: 2,
    value: 1,
    field: :*,

    # Ecto
    belongs_to: :*,
    has_many: :*,
    many_to_many: :*,
    from: :*,

    # Phoenix
    transport: 3,
    plug: :*,
    socket: :*,
    render: :*
  ]
]
