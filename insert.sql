-- добавим исполнителей
INSERT INTO singers(name)
 values ('Сергей Лазарев'), ('Дима Билан'), ('Егор Крид'), ('ST'), 
('Макс Корж'), ('Мэйти'), ('Тимати'), ('Ант'), 
('Григорий Лепс'), ('Филип Киркоров');

INSERT INTO genres(name)
 values ('поп'),('рэп'), ('рок'), ('джаз'), ('шансон');

INSERT INTO albums(name, year)
values ('Всё будет отлично', 2015),('Всё будет прекрасно', 2005), ('Всё будет хуже', 2021),
('Мы счастливы', 1999),('Всё уже прекрасно', 1995), ('Всё ужасно', 2018),
('Всё прошло и печаль тоже', 2003),('Всё огонь', 2018), ('Всё же было лучше', 2017),
('Суперальбом', 2022);

INSERT INTO albums(name, year)
values ('Всё будет Python', 2019),('Всё будет Питон', 2020);

INSERT INTO tracks(albums_id, name, time)
values (1, 'track_01', 120),(2, 'track_02', 245),(3, 'track_03', 456),(4, 'Мой track_04', 198),(5, 'track_05', 170),
(6, 'track_06 мой', 125),(7, 'My track_07', 205),(8, 'track_08', 199),(9, 'track_09', 211),(10, 'track_10', 200),
(1, 'track_11 my', 187),(2, 'track_12', 222),(3, 'My track_13', 314),(4, 'track_14', 304),(5, 'track_15', 312),
(6, 'track_16', 288),(7, 'track_17 мой', 177),(8, 'track_18', 145);

INSERT INTO tracks(albums_id, name, time)
values (11, 'Трек_01', 61),(12, 'Интро_02', 61),(11, 'Супертрек_03', 126),(11, 'Стартрек_04', 138);

INSERT INTO collection(name, year)
values ('Коллекция_2022', 2022),('Коллекция_2021', 2021), ('Коллекция_2020', 2020),
('Коллекция_2019', 2019),('Коллекция_2018', 2018), ('Коллекция_2017', 2017),
('Коллекция_2016', 2016),('Коллекция_2015', 2015), ('Коллекция_2014', 2014),
('Коллекция_2013', 2013);

INSERT INTO collection_tracks (collection_id, tracks_id)
values (1, 18),(1, 17),(2, 16),(2, 15),(3, 14),(3, 13),(4, 12),(4, 11);

INSERT INTO collection_tracks (collection_id, tracks_id)
values (5, 15),(6, 10),(7, 18),(7, 12),(8, 9),(8, 8),(10, 10),(9, 7),(10, 1),(7, 2),(9, 3),(5, 4);

INSERT INTO singers_albums (album_id, singer_id)
values (1, 1),(2, 2),(3, 3),(4, 4),(5, 5),(6, 6),(7, 7),(8, 8),(9, 9),(10, 10);

INSERT INTO singers_albums (album_id, singer_id)
values (11, 1),(12, 2);

INSERT INTO singers_genres (genre_id,singer_id)
values (1, 1),(2, 2),(3, 3),(4, 4),(5, 5),(1, 6),(2, 7),(3, 8),(4, 9),(5, 10);

INSERT INTO singers_genres (genre_id,singer_id)
values (5, 1),(4, 2),(2, 3),(3, 4),(1, 5);

INSERT INTO singers_genres (genre_id,singer_id)
values (4, 1),(3, 1);


 
