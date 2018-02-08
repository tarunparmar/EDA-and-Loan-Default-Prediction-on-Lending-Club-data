## Data download script

## The code will download data from https://www.lendingclub.com/info/download-data.action
## to a /Data folder in the project directory and extract csv files
## It will read all csv files and combine them into one big dataframe 
library(RCurl)
library(plyr)
URL1 <- "https://resources.lendingclub.com/LoanStats3a.csv.zip"
URL2 <- "https://resources.lendingclub.com/LoanStats3b.csv.zip"
URL3 <- "https://resources.lendingclub.com/LoanStats3c.csv.zip"
URL4 <- "https://resources.lendingclub.com/LoanStats3d.csv.zip"
URL5 <- "https://resources.lendingclub.com/LoanStats_2016Q1.csv.zip"
URL6 <- "https://resources.lendingclub.com/LoanStats_2016Q2.csv.zip"
URL7 <- "https://resources.lendingclub.com/LoanStats_2016Q3.csv.zip"
URL8 <- "https://resources.lendingclub.com/LoanStats_2016Q4.csv.zip"
URL9 <- "https://resources.lendingclub.com/LoanStats_2017Q1.csv.zip"
URL10 <- "https://resources.lendingclub.com/LoanStats_2017Q2.csv.zip"
URL11 <- "https://resources.lendingclub.com/LoanStats_2017Q3.csv.zip"

urls <- c(URL1, URL2,URL3,URL4,URL5,URL6,URL7,URL8,URL9,URL10, URL11)
# Create Data directory
dir.create("Data")
accepted_loan_df <- list()
for(i in seq_along(urls)){
  filepath <- paste(getwd(),"/Data/",sep = "")
  zipfilename <- unlist(strsplit(urls[i], "/"))[4]
  datafilename <- substr(unlist(strsplit(urls[i], "/"))[4],1,
                         nchar(unlist(strsplit(urls[i], "/"))[4])-4)
  download.file(urls[i],paste(filepath, zipfilename,sep = ""))
  unzip(paste(filepath,zipfilename,sep = ""), datafilename)
  accepted_loan_df[[i]] <- read.csv(datafilename,skip = 1, 
                                    stringsAsFactors = FALSE)
}

################################################################
# I had to download Full data as FICO score was not available
# This required me to login to the Lending Club account
#
# ## Loop for manually downloaded files
# dir.create("Downloaded Data")
# filepath <- paste(getwd(),"/Downloaded Data/",sep = "")
# dl_files <- list.files(filepath, pattern=".csv$")
# accepted_loan_full_df <- list()
# for(i in seq_along(dl_files)){
#   datafilename <- paste(filepath,dl_files[i], sep = "")
#   accepted_loan_full_df[[i]] <- read.csv(datafilename,skip = 1, 
#                                          stringsAsFactors = FALSE)
# }
# accepted_loan_full_df <- rbind.fill(accepted_loan_full_df)
# write.csv(accepted_loan_full_df, paste(filepath,"/accepted_loan_full_data.csv", 
#                                        sep = ""))

################################################################

## Clean up 
## remove zip files in /Data folder
do.call(file.remove,list(list.files(filepath, pattern=".zip$", full.names = TRUE)))
do.call(file.remove,list(list.files(pattern=".csv$", full.names = TRUE)))

## Combine all data into one big dataframe
accepted_loan_df <- rbind.fill(accepted_loan_df)

saveRDS(accepted_loan_df,paste(filepath,"accepted_loan_data.Rds",sep = ""))


## Download Declined Loan data
## The code will download data from https://www.lendingclub.com/info/download-data.action
## to a /Data folder in the project directory and extract csv files
## It will read all csv files and combine them into one big dataframe 

URL1 <- "https://resources.lendingclub.com/RejectStatsA.csv.zip"
URL2 <- "https://resources.lendingclub.com/RejectStatsB.csv.zip"
URL3 <- "https://resources.lendingclub.com/RejectStatsD.csv.zip"
URL4 <- "https://resources.lendingclub.com/RejectStats_2016Q1.csv.zip"
URL5 <- "https://resources.lendingclub.com/RejectStats_2016Q2.csv.zip"
URL6 <- "https://resources.lendingclub.com/RejectStats_2016Q3.csv.zip"
URL7 <- "https://resources.lendingclub.com/RejectStats_2016Q4.csv.zip"
URL8 <- "https://resources.lendingclub.com/RejectStats_2017Q1.csv.zip"
URL9 <- "https://resources.lendingclub.com/RejectStats_2017Q2.csv.zip"
URL10 <- "https://resources.lendingclub.com/RejectStats_2017Q3.csv.zip"

urls <- c(URL1, URL2,URL3,URL4,URL5,URL6,URL7,URL8,URL9,URL10)

declined_loan_df <- list()
for(i in seq_along(urls)){
  filepath <- paste(getwd(),"/Data/",sep = "")
  zipfilename <- unlist(strsplit(urls[i], "/"))[4]
  datafilename <- substr(unlist(strsplit(urls[i], "/"))[4],1,nchar(unlist(strsplit(urls[i], "/"))[4])-4)
  download.file(urls[i],paste(filepath, zipfilename,sep = ""))
  unzip(paste(filepath,zipfilename,sep = ""), datafilename)
  declined_loan_df[[i]] <- read.csv(datafilename,skip = 1, stringsAsFactors = FALSE)
}

## Clean up 
## remove zip files in /Data folder
do.call(file.remove,list(list.files(filepath, pattern=".zip$", full.names = TRUE)))
do.call(file.remove,list(list.files(pattern=".csv$", full.names = TRUE)))

## Combine all data into one big dataframe
declined_loan_df <- rbind.fill(declined_loan_df)

saveRDS(declined_loan_df, paste(filepath, "declined_loan_data.Rds"))

#rm(list = ls()[!ls() %in% c("loan_df", "declined_loan_df","filepath")])
