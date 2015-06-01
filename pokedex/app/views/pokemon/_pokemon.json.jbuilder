# expect to be passed local pokemon

json.extract!(pokemon, :id, :attack, :defense, :image_url,
  :moves, :name, :poke_type)
