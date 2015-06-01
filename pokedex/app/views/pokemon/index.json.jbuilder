json.array!(@pokemon) do |pokemon|
  json.partial!("pokemon", pokemon: pokemon)
end
