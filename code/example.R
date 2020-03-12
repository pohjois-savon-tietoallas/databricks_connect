library(dplyr)
library(SparkR, lib.loc = .libPaths(c(file.path('~/AppData/spark-2.4.5-bin-hadoop2.7/', 'R', 'lib'), .libPaths())))
Sys.setenv(SPARK_HOME = "/usr/local/lib/python3.7/site-packages/pyspark/")

if(Sys.info()[["sysname"]] == "Darwin"){
    Sys.setenv(JAVA_HOME = "/Library/Java/JavaVirtualMachines/jdk1.8.0_241.jdk/Contents/Home")
}

library(SparkR)
SparkR::sparkR.session()

df <- as.DataFrame(faithful)
head(df)

df1 <- dapply(df, function(x) { x }, schema(df))
collect(df1)


# own data
nba_player_stats <- read.df(source = "csv", path = "dbfs:/FileStore/tables/nbaplayerstats1519_2-d5cfb.csv", header="true", inferSchema = "true", sep = ';')
head(nba_player_stats)
