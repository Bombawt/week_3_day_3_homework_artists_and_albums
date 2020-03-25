require_relative('../db/sql_runner')
require_relative('./artist')

class Album

attr_accessor :title, :genre, :artist_id
attr_writer :id

def initialize(options)
  @title = options['title']
  @genre = options['genre']
  @artist_id = options['artist_id'].to_i
  @id = options['id'].to_i if options['id']
end

def save()

  sql = "INSERT INTO albums
  (
    title,
    genre,
    artist_id
  )
  VALUES
  (
    $1, $2, $3
  )
  RETURNING id"
  values = [@title, @genre, @artist_id]

  @id = SqlRunner.run(sql, values)[0]['id'].to_i

end

def update()
  sql = "
  UPDATE albums SET (
    title,
    genre,
    artist_id
    ) =
    (
      $1, $2, $3
    )
  WHERE id =$4"
  values = [@title, @genre, @artist_id, @id]
  SqlRunner.run(sql, values)
end

def Album.delete_all()
  sql = 'DELETE FROM albums'
  SqlRunner.run(sql, [])
end

def delete()
  sql = "DELETE FROM albums where id = $1"
  values = [@id]
  SqlRunner.run(sql, values)
end


def Album.find(id)
  sql = "SELECT * FROM albums WHERE id = $1"
  values = [id]
  results = SqlRunner.run(sql, values)
  album_hash = results.first
  album = Album.new(album_hash)
  return album
end

def Album.all()
  sql = "SELECT * FROM albums"
  albums = SqlRunner.run(sql, [])
  return albums.map { |album| Album.new(album) }
end









end
