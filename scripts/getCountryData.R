
# ========= Some intro ==============
# This script gathers specified data for a specified country between specified dates from the ...
#... John's hopkins Github page (https://github.com/CSSEGISandData/COVID-19) without a need to clone or fork the repo.
# It collects data from './csse_covid_19_data/csse_covid_19_daily_reports' directly. 
# Might take some time to run depending on your bandwidth/internet connection

# === NOTE =====
# Dates should be in the format: YYYY-mm-dd
# Country name should be exactly the way it is written in the JHU Github page
# If the country has not had any case of Covid-19 on a particular date, this script will break...
#...So, make sure that the country has had a case of Covid on the startDate you slot in. 

# === To Do ====
# Get data across a list of countries
# If country has not had a case on any specified date, script should not break
# Get data across a list of dates (Maybe)
# Make sure the script can gather all the columns available: easily done. 


# ==== Script =============
# rm(list=ls())

library(dplyr)

read.url.csv <- function(url.csv, country='') {
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
    
    specific.data
}


collect.country.data <- function(some.csv.urls, country){
    
    # So far, the script only gathers the data listed below. 
    # But it should be easy to modify this to collect others...
    #...as long as they are present in the original dataset
    
    Last.Update <- c()
    Confirmed <- c()
    Deaths <- c()
    Active <- c()
    Recovered <- c()
    Province_State <- c()
    
    for(each in some.csv.urls) {
        y <- read.url.csv(each, country=country)
        
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
            Confirmed <- append(Confirmed, 'NA')
        } else {
            Confirmed <- append(Confirmed, y$Confirmed)
        }
        
        if (is.null(y$Deaths)) {
            Deaths <- append(Deaths, 'NA')
        } else {
            Deaths <- append(Deaths, y$Deaths)
        }
        
        if (is.null(y$Active)) {
            Active <- append(Active, 'NA')
        } else {
            Active <- append(Active, y$Active)
        }
        
        if (is.null(y$Recovered)) {
            Recovered <- append(Recovered, 'NA')
        } else {
            Recovered <- append(Recovered, y$Recovered)
        }
    }
    
    df <- data.frame(cbind(Province_State, Last.Update, Confirmed, Active, Deaths, Recovered))
    
    df
    
}


get.country.data <- function(country='', startDate='', endDate=''){
    
    # Dates should be in the format: YYYY-mm-dd
    # Country name should be exactly the way it is written in the JHU Github page
    

    base.url <- 'https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_daily_reports/'

    dates <- format(seq(as.Date(startDate), as.Date(endDate), by="days"), format='%m-%d-%Y')

    all.links <- c()
    for(each.date in dates){
        all.links <- append(all.links, paste(base.url, each.date, '.csv', sep=''))
    }
    
    collect.country.data(all.links, country = country)
}

# ===========Test=========== 
# date : YYYY-mm-dd

china.data <- get.country.data(country = 'China', startDate = '2020-05-15', endDate = '2020-06-02')



