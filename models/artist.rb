require_relative('../db/sql_runner')

class Artist

  attr_accessor :name
  attr_reader :id

def initialize(options)
  @id = options['id'].to_i if options['id']
  @name = options['name']
end

def save()
  sql = "INSERT INTO artists
    (
      name
    )
    VALUES
    (
      $1
    )
    RETURNING *
    "

    values = [@name]

    @id = SqlRunner.run(sql, values)[0]['id'].to_i

end

def update()
  sql = "UPDATE artists SET
    name
   =
  $1
  WHERE id = $2"
  values = [@name, @id]
  SqlRunner.run(sql, values)
end

def Artist.delete_all()
  sql = "DELETE FROM artists"
  SqlRunner.run(sql, [])
end

def Artist.find(id)
  sql = "SELECT * FROM artists WHERE id = $1"
  values = [id]
  results = SqlRunner.run(sql, values)
  artist_hash = results.first
  artist = Artist.new(artist_hash)
  return artist
end

def Artist.all()
  sql = "SELECT * FROM artists"
  artists = SqlRunner.run(sql, [])
  return artists.map { |artist| Artist.new(artist) }
end

















end
