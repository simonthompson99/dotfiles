#-- 
rm(list = objects())
options(stringsAsFactors = FALSE,
	scipen = 200)
library(wrangleR)
library(tidyverse)
library(RPostgreSQL)
drv <- dbDriver("PostgreSQL")
p <- getprofile(
				"mis_con"
				"indx_con"
				"dams_con"
				  )
con <- dbConnect(drv,
             dbname = "<db_name>",
             host     = p$host,
             port     = p$port,
             user     = p$user,
             password = p$password)
