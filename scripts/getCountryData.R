
# ===== Some intro ======
# This script gathers specified data for a specified country between specified dates from the ...
#... John's hopkins Github page (https://github.com/CSSEGISandData/COVID-19) without a need to clone or fork the repo.
# It collects data from './csse_covid_19_data/csse_covid_19_daily_reports' directly. 
# Might take some time to run depending on your bandwidth/internet connection

# === NOTE =====
# Dates should be in the format: YYYY-mm-dd
# Country name should be exactly the way it is written in the JHU Github page
# If the country has not had any case of Covid-19 on a particular date, this script will break...
#...So, make sure that the country has had a case of Covid on the startDate you slot in. 
# It also adds a date column corresponding to the date the observations were gotten...
#...This is different from the Last.Update column. 

# === To Do ====
# Get data across a list of countries
# If country has not had a case on any specified date, script should not break
# Get data across a list of dates (Maybe)
# Make sure the script can gather all the columns available: easily done. 

# ==== Script ====
# rm(list=ls())

library(dplyr)

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
    
    cbind(dates, specific.data)
}

# === Test =====
# url.csv <- 'https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_daily_reports/02-28-2020.csv'
# country <- 'Canada'
# dates <- '2020-02-28'
# 
# read.url.csv(url.csv, country, dates)

collect.country.data <- function(some.csv.urls, country, dates){
    
    # So far, the script only gathers the data listed below. 
    # But it should be easy to modify this to collect others...
    #...as long as they are present in the original dataset
    
    Last.Update <- c()
    Confirmed <- c()
    Deaths <- c()
    Active <- c()
    Recovered <- c()
    Province_State <- c()
    Date <- c()
    
    for(i in 1:length(some.csv.urls)) {
        y <- read.url.csv(some.csv.urls[i], country=country, dates[i])
        
        if (is.null(y$dates)) {
            Date <- append(Date, 'NA')
        } else {
            Date <- append(Date, as.character(y$dates))
        }
        
        if ('Last Update' %in% names(y)){
            Last.Update <- append(Last.Update, y$`Last Update`)
        } else if ('Last_Update' %in% names(y)) {
            Last.Update <- append(Last.Update, y$Last_Update)
        } else {
            Last.Update <- append(Last.Update, 'NA')
        }
        
        if ('Province/State' %in% names(y)){
            Province_State <- append(Province_State, y$`Province/State`)
        } else if ('Province_State' %in% names(y)) {
            Province_State <- append(Province_State, y$Province_State)
        } else {
            Province_State <- append(Province_State, 'NA')
        }
        
        if (is.null(y$Confirmed)) {
            Confirmed <- append(Confirmed, 0)
        } else {
            Confirmed <- append(Confirmed, y$Confirmed)
        }
        
        if (is.null(y$Deaths)) {
            Deaths <- append(Deaths, 0)
        } else {
            Deaths <- append(Deaths, y$Deaths)
        }
        
        if (is.null(y$Active)) {
            Active <- append(Active, 0)
        } else {
            Active <- append(Active, y$Active)
        }
        
        if (is.null(y$Recovered)) {
            Recovered <- append(Recovered, 0)
        } else {
            Recovered <- append(Recovered, y$Recovered)
        }
        
    }
    
    data.frame(cbind(Date, Province_State, Last.Update, Confirmed, Active, Deaths, Recovered))
    
}

# ====== Test =============
# all.links <- c('https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_daily_reports/02-28-2020.csv',
#                'https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_daily_reports/02-29-2020.csv')
# country <- 'Canada'
# dates <- c('02-28-2020', '02-29-2020')
# 
# 
# collect.country.data(all.links, country = country, dates)


get.country.data <- function(country='', startDate='', endDate=''){
    
    # Dates should be in the format: YYYY-mm-dd
    # Country name should be exactly the way it is written in the JHU Github page
    

    base.url <- 'https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_daily_reports/'

    dates <- format(seq(as.Date(startDate), as.Date(endDate), by="days"), format='%m-%d-%Y')

    all.links <- c()
    for(each.date in dates){
        all.links <- append(all.links, paste(base.url, each.date, '.csv', sep=''))
    }
    
    collect.country.data(all.links, country = country, dates)
    
}

# === Test ======
# date : YYYY-mm-dd

canada.data <- get.country.data(country = 'Canada', startDate = '2020-03-29', endDate = '2020-04-15')


canada.data



