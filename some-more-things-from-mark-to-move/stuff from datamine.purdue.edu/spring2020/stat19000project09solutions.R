# 1a
# A database can handle massive amounts of data that would
# crash a spreadsheet.
# Faster computation and filtering.
# Data from various sources or tables can be combined much more
# efficiently.
# Databases are easy to integrate with software.
# Etc.

# 1b
# MySQL, Postgresql, MariaDB, Hive, Google BigQuery, etc.

# 1c
# Advantage: faster queries
# Disadvantage: can slow down update/delete/insert because indexes must also be updated.

# 2a
# .tables
# akas      crew      episodes  people    ratings   titles

# 2b
# SELECT * FROM table_name LIMIT(1);
# akas: title_id|title|region|language|types|attributes|is_original_title
# crew: title_id|person_id|category|job|characters
# episodes: episode_title_id|show_title_id|season_number|eposide_number
# people: person_id|name|born|died
# ratings: title_id|rating|votes
# titles: title_id|type|primary_title|original_title|is_adult|premiered|ended|runtime_minutes|genres

# 2c
# SELECT COUNT(*) FROM table_name LIMIT(1);
# akas: 20769495
# crew: 38012729
# episodes: 4658378
# people: 9912394
# ratings: 1028573
# titles: 6579412

# 3a
# SELECT * FROM titles ORDER BY runtime_minutes DESC LIMIT(10);
# tt8273150|movie|Logistics|Logistics|0|2012||51420|Documentary
# tt2659636|movie|Modern Times Forever|Modern Times Forever|0|2011||14400|Documentary
# tt11707418|tvSpecial|Svalbard Minute by Minute|Svalbard minutt for minutt|0|2020||13319|Adventure,Documentary
# tt10844900|movie|Qw|Qw|0|2019||10062|Drama
# tt2355497|movie|Beijing 2003|Beijing 2003|0|2004||9000|Documentary
# tt0466521|tvSeries|The Sharing Circle|The Sharing Circle|0|1991|2008|8400|Documentary
# tt5068890|movie|Hunger!|Hunger!|0|2015||6000|Documentary,Drama
# tt11718154|short|Walnut|Walnut|0|2020||5760|Short
# tt7357138|tvSpecial|Katy Perry Live: Witness World Wide|Katy Perry Live: Witness World Wide|0|2017||5760|Music,Reality-TV
# tt1806963|video|Matrjoschka|Matrjoschka|0|2006||5700|Drama

# 3b
# SELECT DISTINCT genres FROM titles;

# 3c
# SELECT COUNT(*) FROM titles WHERE primary_title!=original_title;
# 101712

# 3d
# .mode csv
# .output friends.csv
# SELECT * FROM titles AS t, episodes AS e WHERE t.title_id="tt0108778" AND e.show_title_id=t.title_id ORDER BY e.season_number, e.episode_number;




# people:
