
# ===== Some intro ======
# This script gathers specified data for a specified country between specified dates from the ...
#... John's hopkins Github page (https://github.com/CSSEGISandData/COVID-19) without a need to clone or fork the repo.
# It collects data from './csse_covid_19_data/csse_covid_19_daily_reports' directly and returns a csv file of the data
# Might take some time to run depending on your bandwidth/internet connection

# === NOTE =====

# The main call is pull.country.data(): takes 
#   1. country: A country name or a list of country names 
#   2. startDate and endDate: Two dates (or only a start date): As long as the JHU github page is been updated daily, there should be no problem.
#       If an endDate is not provided, it automatically pulls data from the startDate up to the date PRIOR to your current date.
#       This is to ensure that the JHU Github page has been updated and the script does not break. 
#       ANYWAY, PLEASE, TRY TO PROVIDE A DATE CONSISTENT WITH WHAT IS AVAILABLE ON THE JHU GITHUB PAGE
#       PLEASE, NOTE:
#       >>> Dates MUST be in the format: YYYY-mm-dd <<<
#   3. saveDir (optional): a directory location to save the csv output. If a directory is not provided, it saves the file to the current working directory

# The output is a csv file of the data requested. 

# Country name should be exactly the way it is written in the JHU Github page: ALTERNATIVELY, YOU CAN provide what you think matches the names:
#... e.g: China and Mainland China. Country can take a list of countries. 

# It also adds a date column corresponding to the date the observations were gotten...
#...This is different from the Last.Update column. 

# === To Do ====
# Get data across a list of countries: RESOLVED

# If country has not had a case on any specified date and the country name is not present in a JHU dataset on a particular date...
#...script should not break: RESOLVED. IN THIS CASE, IT DOES NOT RETURN ANYTHING FOR THAT DATE

# Get data across a list of dates (Maybe): RESOLVED

# Make sure the script can gather all the columns available: easily done. 


# ==== Script ====
# rm(list=ls())

library(dplyr)

# ==== read.url.csv() =============
read.url.csv <- function(url.csv, country='', dates) {
    
    url.csv.data <- read.csv(url(url.csv), header=T, stringsAsFactors = F,
                             check.names = F)
    
    if ('Country/Region' %in% names(url.csv.data)) {
        if (country %in% url.csv.data$`Country/Region`) {
            specific.data <- url.csv.data %>% filter(`Country/Region` == country)
        }
        
    } else if ('Country_Region' %in% names(url.csv.data)) {
        if (country %in% url.csv.data$Country_Region) {
            specific.data <- url.csv.data %>% filter(Country_Region == country)
        }
    } 
    
    if ('Country/Region' %in% names(url.csv.data)) {
        if (! country %in% url.csv.data$`Country/Region`) {
            return(NULL)
        }
        
    } else if ('Country_Region' %in% names(url.csv.data)) {
        if (! country %in% url.csv.data$Country_Region) {
            return(NULL)
        }
    } 
    
    y <- cbind(dates, country, specific.data)
    
    if (!'Active' %in% names(y)){
        y <- y %>% mutate(Active=0)
    }
    
    if ('Last Update' %in% names(y)){
        names(y)[which('Last Update' == names(y))] <- 'Last.Update'
    } else if ('Last_Update' %in% names(y)) {
        names(y)[which('Last_Update' == names(y))] <- 'Last.Update'
    }
    
    if ('Province/State' %in% names(y)){
        names(y)[which('Province/State' == names(y))] <- 'Province.State'
    } else if ('Province_State' %in% names(y)) {
        names(y)[which('Province_State' == names(y))] <- 'Province.State'
    }
    
    y.filtered <- y %>% select(country, dates, Last.Update, Confirmed, Deaths, Recovered, Province.State, Active)
    y.filtered$country <- as.character(y.filtered$country)
    y.filtered$dates <- as.character(y.filtered$dates)

    data.frame(y.filtered)
}

# === Test =====
# url.csv <- 'https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_daily_reports/05-29-2020.csv'
# country <- 'Nigeria'
# dates <- '2020-05-29'
# h <- read.url.csv(url.csv, country, dates)
# h

# ===== collect.country.data() =============
collect.country.data <- function(country, dates){
  
    base.url <- 'https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_daily_reports/'
    combinations <- unlist(lapply(dates, function(x) lapply(country, function (y) c(x, y))), recursive=F)
    output <- list()
    
    for(i in 1:length(combinations)){
        temp.date <- unlist(combinations[i])[1]
        temp.country <- unlist(combinations[i])[2]
        temp <- read.url.csv(paste(base.url, temp.date, '.csv', sep=''), temp.country, temp.date)
        output[[i]] <- temp
    }
    do.call(rbind, output)
}

# ====== Test ========
# country <- c('Nigeria', 'Japan', 'China', 'Mainland China')
# dates <- c('02-28-2020', '02-29-2020', '03-01-2020')
# j <- collect.country.data(country, dates)
# j

# ====== get.country.data() =============
pull.country.data <- function(country, startDate='', endDate='', saveDir=''){
    
    # Dates should be in the format: YYYY-mm-dd
    
    # Country name should be exactly the way it is written in the JHU Github page...
    #...Country can also take a list.
    
    # The output is a csv file of the data requested
    
    
    if(missing(saveDir)){
        saveDir = './'
    } 
    
    if(missing(endDate)){
        endDate = Sys.Date()-1
    }
    
    if(missing(startDate)){
        return('Please provide a start date in the format YYYY-mm-dd')
        break
    }
    
    dates <- format(seq(as.Date(startDate), as.Date(endDate), by="days"), format='%m-%d-%Y')
    country.data <- data.frame(collect.country.data(country, dates))
    
    if(length(country) == 1){
        write.csv(country.data, file=paste(saveDir, country, '_data', '.csv', sep=''), row.names = F)
    } else if(length(country) > 1){
        write.csv(country.data, file=paste(saveDir, 'countries_data', '.csv', sep=''), row.names = F)
    }
}

# === Test ======
# date : YYYY-mm-dd

# country = c('Nigeria', 'Japan', 'China', 'Mainland China')
# pull.country.data(country, startDate = '2020-02-28', endDate = '2020-03-02')

# country = 'China'
# pull.country.data(country, startDate = '2020-01-28', endDate = '2020-05-28')

# country = c('Nigeria')
# pull.country.data(country, startDate = '2020-02-29', endDate = '2020-03-01', saveDir='data/')

