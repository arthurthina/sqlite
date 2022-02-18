library(RSQLite)

data("mtcars")
mtcars$car_names <- rownames(mtcars)
rownames(mtcars) <- c()
head(mtcars)

conn <- dbConnect(RSQLite::SQLite(), "CarsDB.db")


dbWriteTable(conn, "cars_data", mtcars)

dbListTables(conn)


car <- c('Camaro', 'California', 'Mustang', 'Explorer')
make <- c('Chevrolet','Ferrari','Ford','Ford')
df1 <- data.frame(car,make)
car <- c('Corolla', 'Lancer', 'Sportage', 'XE')
make <- c('Toyota','Mitsubishi','Kia','Jaguar')
df2 <- data.frame(car,make)

dfList <- list(df1,df2)


for(k in 1:length(dfList)){
  dbWriteTable(conn,"Cars_and_Makes", dfList[[k]], append = TRUE)
}

dbListTables(conn)

dbGetQuery(conn, "SELECT * FROM Cars_and_Makes")

test <- dbGetQuery(conn, "SELECT * FROM cars_data")
