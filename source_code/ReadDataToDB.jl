using DataFrames
import XLSX 
using SQLite
using TableIO

# create SQLite database as NWS.db for new warming site
NWS = SQLite.DB("NWS.db")

# read in data as dataframe; example with soil respiration
df_SR = DataFrame(XLSX.readtable("soil_respiration_2020_2021_2022.xlsx","Sheet1")...)
df_SM = DataFrame(XLSX.readtable("soil_moisture_2020_2021_2022.xlsx","Sheet1")...)

# writing dataframe into different tables "SoilRespiration","SoilTemperature","SoilMoisture","ANPP","GPP","ER" etc
write_table!("NWS.db", "SoilRespiration", df_SR)
write_table!("NWS.db", "SoilTemperature", df)
write_table!("NWS.db", "SoilMoisture", df_SM)
write_table!("NWS.db", "ANPP", df)
write_table!("NWS.db", "GPP", df)
write_table!("NWS.db", "ER", df)
write_table!("NWS.db", "SpeciesComposition", df)

# check tables
DataFrame(SQLite.tables(NWS))

# check columns in a table 
q = "SELECT * FROM SoilMoisture"
data = SQLite.DBInterface.execute(NWS,q)
DataFrame(data)
SQLite.columns(NWS,"SoilRespiration")
DataFrame(SQLite.columns(NWS,"SoilRespiration"))

# drop a table from db
SQLite.drop!(NWS, "SoilRespiration")
SQLite.drop!(NWS, "SoilMoisture")

# -- SQLite CheatSheet 

# -- how to select all rows
# -- SELECT * FROM SoilRespiration;
# -- SELECT * FROM SoilRespirationx;
# -- SELECT * FROM my_table;

# -- how to select data by columns
# -- SELECT Samples, Date FROM SoilRespiration;

# -- how to srot data by a column
# -- SELECT Samples, DeepShallow FROM SoilRespiration ORDER BY DeepShallow ASC; 


# -- SQLite Cheat Sheet

# -- how to select all rows from a table
# -- SELECT * FROM Genre;
# -- SELECT * FROM Artist;
# -- SELECT * FROM Album;
# -- SELECT * FROM Track;

# -- how to select columns in a table
# -- SELECT FirstName, LastName, Email FROM Customer;

# -- how to sort data by a column
# -- SELECT FirstName, LastName, Email FROM Customer ORDER BY FirstName ASC;
# -- SELECT FirstName, LastName, Email FROM Customer ORDER BY LastName DESC;

# -- how to filter data using a search condition
# -- SELECT * FROM Album WHERE ArtistId = 1;

# -- how to filter data using comparison operators
# -- SELECT * FROM Album WHERE ArtistId >= 2 AND ArtistId <= 5;

# -- how to filter data using logical operators
# -- SELECT * FROM Album WHERE ArtistId BETWEEN 6 AND 10;

# -- how to limit the number of rows to display
# -- SELECT * FROM Track LIMIT 10;

# -- how to filter data using pattern matching
# -- SELECT * FROM Track WHERE Name LIKE 'b%';
# -- SELECT * FROM Track WHERE Name LIKE '%dog%';

# -- how to use INNER JOIN
# SELECT * FROM Album INNER JOIN Artist ON Artist.ArtistId = Album.ArtistId;
# -- SELECT * FROM Track INNER JOIN Album ON Album.AlbumId = Track.AlbumId;

# -- SELECT
# --     TrackId, Title, Name
# -- FROM
# --     Track
# -- INNER JOIN
# --     Album ON Album.AlbumId = Track.AlbumId
# -- ;

# -- how to use an alias
# -- SELECT
# --     TrackId,
# --     Genre.Name AS Genre,
# --     Artist.Name AS Artist,
# --     Album.Title AS Album,
# --     Track.Name AS Track
# -- FROM
# --     Track
# -- INNER JOIN
# --     Artist ON Artist.ArtistId = Album.ArtistId,
# --     Album ON Album.AlbumId = Track.AlbumId,
# --     Genre ON Genre.GenreId = Track.GenreId
# -- ;