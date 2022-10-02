-- название и год выхода альбомов, вышедших в 2018 году;
select albums_name, year from albums
where year = 2018;

-- название и продолжительность самого длительного трека;
select tracks_name, time from tracks
where time = (SELECT max(time) FROM tracks);

-- название треков, продолжительность которых не менее 3,5 минуты;
select tracks_name, time from tracks
where time >= 210;

-- названия сборников, вышедших в период с 2018 по 2020 год включительно;
select collection_name from collection
where year between 2018 and 2020;

-- исполнители, чье имя состоит из 1 слова;
select name from singers
where name not like '% %';

-- название треков, которые содержат слово "мой"/"my"
select tracks_name from tracks
where tracks_name like '%My%' or tracks_name like '%my%' or tracks_name like '%мой%' or tracks_name like '%Мой%';
-------------------------------------------------------------------------------------------

--1.количество исполнителей в каждом жанре;
select genres_name, COUNT(singer_id) from singers_genres sg
join genres g ON g.id = sg.genre_id
GROUP BY genres_name;

--2.количество треков, вошедших в альбомы 2019-2020 годов;
SELECT albums_name, COUNT(track_id) FROM albums a
JOIN tracks t ON a.id = t.albums_id
WHERE year BETWEEN 2019 and 2020
GROUP BY albums_name;

--3.средняя продолжительность треков по каждому альбому;
SELECT albums_name, AVG(time) FROM albums a
JOIN tracks t ON a.id = t.albums_id
GROUP BY albums_name;

--4.все исполнители, которые не выпустили альбомы в 2020 году;
SELECT name, year FROM singers s
JOIN singers_albums sa ON s.id = sa.singer_id
JOIN albums a ON a.id = sa.album_id
WHERE s.name NOT in (SELECT distinct s.name FROM singers where year = 2020)
ORDER by name;

--5.названия сборников, в которых присутствует конкретный исполнитель (выберите сами);
SELECT collection_name, name FROM collection c
JOIN collection_tracks ct ON c.id = ct.collection_id
JOIN tracks t ON t.track_id = ct.tracks_id
JOIN albums a ON a.id = t.albums_id
JOIN singers_albums sa ON sa.album_id = a.id
JOIN singers s ON s.id = sa.singer_id
WHERE name like 'ST';

--6.название альбомов, в которых присутствуют исполнители более 1 жанра;
SELECT albums_name, COUNT(genre_id) FROM albums a
JOIN singers_albums sa ON sa.album_id = a.id
JOIN singers s ON s.id = sa.singer_id
JOIN singers_genres sg ON s.id = sg.singer_id
GROUP by albums_name
HAVING COUNT(genre_id) > 1;

--7.наименование треков, которые не входят в сборники;
SELECT tracks_name FROM tracks t
LEFT JOIN collection_tracks ct ON ct.tracks_id = t.track_id
WHERE tracks_id is null;

--8.исполнителя(-ей), написавшего самый короткий по продолжительности трек (теоретически таких треков может быть несколько);
SELECT name FROM singers s
JOIN singers_albums sa ON s.id = sa.singer_id
JOIN albums a ON a.id = sa.album_id
JOIN tracks t ON t.albums_id = a.id
WHERE time = (SELECT MIN(time)FROM tracks);

--9.название альбомов, содержащих наименьшее количество треков.
SELECT albums_name, COUNT(track_id) FROM albums a
JOIN tracks t ON t.albums_id = a.id
GROUP by albums_name
HAVING count(track_id) = (SELECT count(track_id) from tracks
        group by albums_id
        order by count
        limit 1);
