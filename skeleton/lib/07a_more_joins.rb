# == Schema Information
#
# Table name: albums
#
#  asin        :string       not null, primary key
#  title       :string
#  artist      :string
#  price       :float
#  rdate       :date
#  label       :string
#  rank        :integer
#
# Table name: styles
#
# album        :string       not null
# style        :string       not null
#
# Table name: tracks
# album        :string       not null
# disk         :integer      not null
# posn         :integer      not null
# song         :string

require_relative './sqlzoo.rb'

def alison_artist
  # Select the name of the artist who recorded the song 'Alison'.
  execute(<<-SQL)
    SELECT albums.artist
    FROM albums INNER JOIN tracks ON albums.asin = tracks.album
    WHERE tracks.song = 'Alison';
  SQL
end

def exodus_artist
  # Select the name of the artist who recorded the song 'Exodus'.
  execute(<<-SQL)
    SELECT albums.artist
    FROM albums INNER JOIN tracks ON albums.asin = tracks.album
    WHERE tracks.song = 'Exodus';
  SQL
end

def blur_songs
  # Select the `song` for each `track` on the album `Blur`.
  execute(<<-SQL)
    SELECT tracks.song
    FROM tracks INNER JOIN albums ON albums.asin = tracks.album
    WHERE albums.title = 'Blur';
  SQL
end

def heart_tracks
  # For each album show the title and the total number of tracks containing
  # the word 'Heart' (albums with no such tracks need not be shown). Order first by
  # the number of such tracks, then by album title.
  execute(<<-SQL)
    SELECT albums.title, COUNT(*)
    FROM albums INNER JOIN tracks ON albums.asin = tracks.album
    WHERE tracks.song LIKE '%Heart%'
    GROUP BY albums.title
    ORDER BY COUNT(*) desc, albums.title;
  SQL
end

def title_tracks
  # A 'title track' has a `song` that is the same as its album's `title`. Select
  # the names of all the title tracks.
  execute(<<-SQL)
    SELECT albums.title
    FROM albums INNER JOIN tracks ON albums.asin = tracks.album
    WHERE albums.title = tracks.song;
  SQL
end

def eponymous_albums
  # An 'eponymous album' has a `title` that is the same as its recording
  # artist's name. Select the titles of all the eponymous albums.
  execute(<<-SQL)
    SELECT DISTINCT albums.title
    FROM albums INNER JOIN tracks ON albums.asin = tracks.album
    WHERE albums.title = albums.artist;
  SQL
end

def song_title_counts
  # Select the song names that appear on more than two albums. Also select the
  # COUNT of times they show up.
  execute(<<-SQL)
    SELECT tracks.song, COUNT(*)
    FROM tracks INNER JOIN albums ON albums.asin = tracks.album
    GROUP BY tracks.song
    HAVING COUNT(*) > 2


  SQL
end

def best_value
  # A "good value" album is one where the price per track is less than 50
  # pence. Find the good value albums - show the title, the price and the number
  # of tracks.
  execute(<<-SQL)
    SELECT albums.title, albums.price, COUNT(*)
    FROM albums INNER JOIN tracks ON tracks.album = albums.asin
    GROUP BY albums.title, albums.price
    HAVING albums.price/COUNT(*) < .50;

  SQL
end

def top_track_counts
  # Wagner's Ring cycle has an imposing 173 tracks, Bing Crosby clocks up 101
  # tracks. List the top 10 albums in order of track count. Select both the
  # album title and the track count.
  execute(<<-SQL)
  SELECT albums.title, COUNT(*)
  FROM albums INNER JOIN tracks ON albums.asin = tracks.album
  GROUP BY albums.asin
  ORDER BY COUNT(*) desc LIMIT 10;
  SQL
end

def soundtrack_wars
  # Select the artist, who has recorded the most soundtracks, as well as the
  # number of albums. HINT: use LIKE '%Soundtrack%' in your query.
  execute(<<-SQL)
    SELECT albums.artist, COUNT(*)
    FROM albums INNER JOIN styles ON styles.album = albums.asin
    WHERE styles.style LIKE '%Soundtrack%'
    GROUP BY albums.artist
    ORDER BY COUNT(*) desc LIMIT 1;
  SQL
end

def expensive_tastes
  # Select the five styles of music with the highest average price per track,
  # along with the price per track. One or more of each aggregate functions,
  # subqueries, and joins will be required.
  #
  # HINT: Start by getting the number of tracks per album. You can do this in a
  # subquery. Next, JOIN the styles table to this result and use aggregates to
  # determine the average price per track.

  execute(<<-SQL)
  --
  -- SELECT styles.style, SUM(album_count_tracks.album_price) AS sum, album_count_tracks.num_of_tracks AS track_count, (SUM(album_count_tracks.album_price)/album_count_tracks.num_of_tracks) AS average_price
  -- FROM styles
  -- INNER JOIN (SELECT albums.asin AS album_id, albums.price AS album_price, COUNT(*) AS num_of_tracks
  -- FROM albums
  -- INNER JOIN tracks ON tracks.album = albums.asin
  -- GROUP BY albums.asin) AS album_count_tracks
  --   ON styles.album = album_count_tracks.album_id
  -- GROUP BY styles.style, album_count_tracks.num_of_tracks
  -- ORDER BY average_price desc;
  --
  --
  -- SELECT styles.style,
  --        Sum(album_count_tracks.album_price)
  --        AS sum,
  --        album_count_tracks.num_of_tracks
  --        AS track_count,
  -- ( Sum(album_count_tracks.album_price) / album_count_tracks.num_of_tracks ) AS
  -- average_price
  -- FROM   styles
  --        INNER JOIN (SELECT albums.asin  AS album_id,
  --                           albums.price AS album_price,
  --                           Count(*)     AS num_of_tracks
  --                    FROM   albums
  --                           INNER JOIN tracks
  --                                   ON tracks.album = albums.asin
  --                    GROUP  BY albums.asin) AS album_count_tracks
  --                ON styles.album = album_count_tracks.album_id
  -- GROUP  BY styles.style,
  --           album_count_tracks.num_of_tracks
  -- ORDER  BY average_price DESC;



    --
    -- SELECT styles.style, SUM(album_tracks.album_price), SUM(album_tracks.num_of_tracks), SUM(album_tracks.album_price)/SUM(album_tracks.num_of_tracks) AS average
    -- FROM styles
    -- INNER JOIN (SELECT albums.asin AS album_id, albums.price AS album_price, COUNT(*) AS num_of_tracks -- returns the average price per track
    -- FROM albums
    -- INNER JOIN tracks ON tracks.album = albums.asin
    -- GROUP BY albums.asin) album_tracks ON album_tracks.album_id = styles.album
    -- GROUP BY styles.style
    -- HAVING SUM(album_tracks.album_price)/SUM(album_tracks.num_of_tracks) IS NOT NULL
    -- ORDER BY average desc LIMIT 5;
    --

  SELECT styles.style, SUM(album_tracks.album_price)/SUM(album_tracks.num_of_tracks) AS average
  FROM styles
  INNER JOIN (SELECT albums.asin AS album_id, albums.price AS album_price, COUNT(*) AS num_of_tracks -- returns the average price per track
  FROM albums
  INNER JOIN tracks ON tracks.album = albums.asin
  GROUP BY albums.asin) album_tracks ON album_tracks.album_id = styles.album
  GROUP BY styles.style
  HAVING SUM(album_tracks.album_price)/SUM(album_tracks.num_of_tracks) IS NOT NULL
  ORDER BY average desc LIMIT 5;






  --
  --
  --
  -- SELECT styles.*, album_tracks.album_id, album_tracks.album_price, album_tracks.num_of_tracks
  -- FROM styles
  -- INNER JOIN (SELECT albums.asin AS album_id, albums.price AS album_price, COUNT(*) AS num_of_tracks -- returns the average price per track
  -- FROM albums
  -- INNER JOIN tracks ON tracks.album = albums.asin
  -- GROUP BY albums.asin) album_tracks ON album_tracks.album_id = styles.album
  --
  --
  -- --
  -- -- (SELECT albums.asin, COUNT(*) AS num_of_tracks -- returns the average price per track
  -- -- FROM albums
  -- -- INNER JOIN tracks ON tracks.album = albums.asin
  -- -- GROUP BY albums.asin) AS album_count_tracks
  -- --
  --   SELECT albums.asin, COUNT(*) AS num_of_tracks -- returns the average price per track
  --   FROM albums
  --   INNER JOIN tracks ON tracks.album = albums.asin
  --   GROUP BY albums.asin
  -- --
  -- SELECT styles.*
  -- FROM styles

  --   join the tables on the asin, then group by style.
  SQL
end
