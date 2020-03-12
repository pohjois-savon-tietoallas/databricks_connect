# After setting up databricks connect (read databricks_connect_instructions.Rmd) this script should work
library(dplyr)

# Setup environment variables ----
if(Sys.info()[["sysname"]] == "Darwin"){
    # Mac OSX
    library(SparkR, lib.loc = .libPaths(c(file.path('~/AppData/spark-2.4.5-bin-hadoop2.7/', 'R', 'lib'), .libPaths())))
    Sys.setenv(SPARK_HOME = "/usr/local/lib/python3.7/site-packages/pyspark/")
    Sys.setenv(JAVA_HOME = "/Library/Java/JavaVirtualMachines/jdk1.8.0_241.jdk/Contents/Home")
}else if(Sys.info()[["sysname"]] == "Windows"){
    # Windows
    library(SparkR, lib.loc = .libPaths(c(file.path("C:\\Users\\", Sys.info()[["user"]],"\\AppData\\Local\\Apache\\Spark\\Cache\\spark-2.4.3-bin-hadoop2.7", "R", "lib"), .libPaths())))
    Sys.setenv(SPARK_HOME = paste0("c:\\Users\\", Sys.info()[["user"]] ,"\\appdata\\local\\continuum\\anaconda3\\envs\\dbconnect_6_2\\lib\\site-packages\\pyspark"))
}

# First test ----
library(SparkR)
SparkR::sparkR.session()

df <- as.DataFrame(faithful)
head(df)

df1 <- dapply(df, function(x) { x }, schema(df))
collect(df1)

# check out own data ----
nba_player_stats <- read.df(source = "csv", path = "dbfs:/FileStore/tables/nbaplayerstats1519_2-d5cfb.csv", header="true", inferSchema = "true", sep = ';')
head(nba_player_stats)

# Stop session ----
SparkR::sparkR.session.stop()