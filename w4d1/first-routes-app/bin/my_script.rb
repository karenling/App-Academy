require 'addressable/uri'
require 'rest-client'


def create_contact_share
  url = Addressable::URI.new(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: '/contact_shares.json'
  ).to_s

  puts RestClient.post(url,
    { contact_share: { contact_id: 5, user_id: 2 }}
  )
end

# create_contact_share

def destroy_contact_share
  url = Addressable::URI.new(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: '/contact_shares/2.json'
  ).to_s

  puts RestClient.delete(url)
end

destroy_contact_share


def destroy_contact
  url = Addressable::URI.new(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: '/contacts/4.json'
  ).to_s

  puts RestClient.delete(url)
end

# destroy_contact



def update_contact
  url = Addressable::URI.new(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: '/contacts/4.json'
  ).to_s

  puts RestClient.patch(url,
                  { contact: { name: "CJ Avilla"}}
      )
end

# update_contact


def create_contact
  url = Addressable::URI.new(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: '/contacts.json'
  ).to_s

  puts RestClient.post(url,
                  { contact: { name: "CJ", email: "cj@email.com", user_id: 1 }}
      )
end

# create_contact


def get_index
  url = Addressable::URI.new(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: '/users.html',
    query_values: { 'users[name]' => "Alex" }
  ).to_s

  # query_values = { 'users[name]' => "Alex" }
  # puts RestClient.post(url, query_values)


  puts RestClient.post(url)
end

def update_user
  url = Addressable::URI.new(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: '/users/1.json',
  ).to_s

  begin
    puts RestClient.put(
      url,
      { 'user[name]' => 'Aleksey' }
    )
  rescue RestClient::Exception => e
    puts e.message
  end
end

# update_user

def create_user
  url = Addressable::URI.new(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: '/users.json'
  ).to_s

  begin
    puts RestClient.post(
      url,
      { user: { name: "Gizmo", email: "gizmo@gizmo.gizmo" } }
    )
  rescue RestClient::Exception => e
    puts e.message
  end
end

# create_user


def show_user
  url = Addressable::URI.new(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: '/users/4.json'
  ).to_s

  begin
    puts RestClient.get(url)
  rescue RestClient::Exception => e
    puts e.message
  end
end

# show_user


def destroy_user
  url = Addressable::URI.new(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: '/users/3.json',
  ).to_s

  begin
    puts RestClient.delete(url)
  rescue RestClient::Exception => e
    puts e.message
  end
end

# destroy_user
