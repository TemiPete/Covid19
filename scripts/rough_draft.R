# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# # out <- c()
# # for(each in all.links){
# #     out <- append(out, read.naij.url(each))
# # }
# # 
# 
# 
# 
# 
# data <- collect.Naija.url(all.links)
# 
# 
# 
# # The function below is like the one above but only when you cloned the repository to your local git ================
# # list all the files in that directory that end with .csv:
# data.dir <- './csse_covid_19_data/csse_covid_19_daily_reports'
# 
# naij.dir <- './nigeria_data/'
# 
# files <- list.files(path=data.dir, pattern="*.csv", full.names=TRUE, recursive=FALSE)
# 
# # Nigeria's first covid 19 case was reported in Feb 28, 2020: Corresponds to index 38 in files object
# naij.files <- files[38:length(files)]
# 
# # This function returns a dataframe with one row, corresponding to the observation for Nigeria
# read.naij <- function(f) {
#     f.data <- read.csv(f, header=T, stringsAsFactors = F,
#                        check.names = F)
#     
#     if ('Country/Region' %in% names(f.data)) {
#         if ('Nigeria' %in% f.data$`Country/Region`) {
#             naij <- f.data %>% filter(`Country/Region` == 'Nigeria')
#         }
#         
#     } else if ('Country_Region' %in% names(f.data)) {
#         if ('Nigeria' %in% f.data$Country_Region) {
#             naij <- f.data %>% filter(Country_Region == 'Nigeria')
#         }
#     } 
#     naij
# }
# 
# # Collects the data across all .csv files and creates a dataframe
# collect.Naija <- function(some.csv.files){
#     
#     Last.Update <- c()
#     Confirmed <- c()
#     Deaths <- c()
#     Active <- c()
#     Recovered <- c()
#     
#     for(each in some.csv.files) {
#         y <- read.naij(each)
#         
#         if ('Last Update' %in% names(y)){
#             Last.Update <- append(Last.Update, y$`Last Update`)
#         } else if ('Last_Update' %in% names(y)) {
#             Last.Update <- append(Last.Update, y$Last_Update)
#         } else {
#             Last.Update <- append(Last.Update, 'NA')
#         }
#         
#         if (is.null(y$Confirmed)) {
#             Confirmed <- append(Confirmed, 'NA')
#         } else {
#             Confirmed <- append(Confirmed, y$Confirmed)
#         }
#         
#         if (is.null(y$Deaths)) {
#             Deaths <- append(Deaths, 'NA')
#         } else {
#             Deaths <- append(Deaths, y$Deaths)
#         }
#         
#         if (is.null(y$Active)) {
#             Active <- append(Active, 'NA')
#         } else {
#             Active <- append(Active, y$Active)
#         }
#         
#         if (is.null(y$Recovered)) {
#             Recovered <- append(Recovered, 'NA')
#         } else {
#             Recovered <- append(Recovered, y$Recovered)
#         }
#     }
#     
#     df <- data.frame(cbind(Last.Update, Confirmed, Active, Deaths, Recovered))
#     
#     df
#     
# }
# 
# naija.data <- collect.Naija(naij.files)
# 
# 
# 
# 
# # ===== Dirty scripts ==================
# 
# 
# # samp.one <- "./csse_covid_19_data/csse_covid_19_daily_reports/02-28-2020.csv"
# # samp.two <- "./csse_covid_19_data/csse_covid_19_daily_reports/05-17-2020.csv"
# # samp.three <- "./csse_covid_19_data/csse_covid_19_daily_reports/05-30-2020.csv"
# # samp.four <- "./csse_covid_19_data/csse_covid_19_daily_reports/05-22-2020.csv"
# # 
# # fyl <- c(samp.one, samp.two, samp.three, samp.four)
# # 
# # read.naij(samp.one)
# # 
# # 
# # z <- read.csv(samp.one, header=T, check.names = F, stringsAsFactors = F)
# # 
# # 
# # z.three <- read.csv(samp.three, header=T, check.names = F, stringsAsFactors = F)
# # 
# # names(z)[which('Last Update' == names(z))] <- 'Last_Update'
# # 
# # y <- c()
# # 
# # z <- z %>% filter(`Country/Region` == 'Nigeria')
# # 
# # z.three <- z.three %>% filter(Country_Region == 'Nigeria')
# # 
# # y <- append(y, z$Last_Update)
# # y <- append(y, z.three$Last_Update)
# # 
# # y
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# # ====== An old script that works only when the repo is cloned to my local git ====================
# # # out <- c()
# # # for(each in all.links){
# # #     out <- append(out, read.naij.url(each))
# # # }
# # # 
# # 
# # 
# # 
# # 
# # data <- collect.Naija.url(all.links)
# # 
# # 
# # 
# # # The function below is like the one above but only when you cloned the repository to your local git ================
# # # list all the files in that directory that end with .csv:
# # data.dir <- './csse_covid_19_data/csse_covid_19_daily_reports'
# # 
# # naij.dir <- './nigeria_data/'
# # 
# # files <- list.files(path=data.dir, pattern="*.csv", full.names=TRUE, recursive=FALSE)
# # 
# # # Nigeria's first covid 19 case was reported in Feb 28, 2020: Corresponds to index 38 in files object
# # naij.files <- files[38:length(files)]
# # 
# # # This function returns a dataframe with one row, corresponding to the observation for Nigeria
# # read.naij <- function(f) {
# #     f.data <- read.csv(f, header=T, stringsAsFactors = F,
# #                        check.names = F)
# #     
# #     if ('Country/Region' %in% names(f.data)) {
# #         if ('Nigeria' %in% f.data$`Country/Region`) {
# #             naij <- f.data %>% filter(`Country/Region` == 'Nigeria')
# #         }
# #         
# #     } else if ('Country_Region' %in% names(f.data)) {
# #         if ('Nigeria' %in% f.data$Country_Region) {
# #             naij <- f.data %>% filter(Country_Region == 'Nigeria')
# #         }
# #     } 
# #     naij
# # }
# # 
# # # Collects the data across all .csv files and creates a dataframe
# # collect.Naija <- function(some.csv.files){
# #     
# #     Last.Update <- c()
# #     Confirmed <- c()
# #     Deaths <- c()
# #     Active <- c()
# #     Recovered <- c()
# # 
# #     for(each in some.csv.files) {
# #         y <- read.naij(each)
# #         
# #         if ('Last Update' %in% names(y)){
# #             Last.Update <- append(Last.Update, y$`Last Update`)
# #         } else if ('Last_Update' %in% names(y)) {
# #             Last.Update <- append(Last.Update, y$Last_Update)
# #         } else {
# #             Last.Update <- append(Last.Update, 'NA')
# #         }
# #         
# #         if (is.null(y$Confirmed)) {
# #             Confirmed <- append(Confirmed, 'NA')
# #         } else {
# #             Confirmed <- append(Confirmed, y$Confirmed)
# #         }
# #         
# #         if (is.null(y$Deaths)) {
# #             Deaths <- append(Deaths, 'NA')
# #         } else {
# #             Deaths <- append(Deaths, y$Deaths)
# #         }
# #         
# #         if (is.null(y$Active)) {
# #             Active <- append(Active, 'NA')
# #         } else {
# #             Active <- append(Active, y$Active)
# #         }
# #         
# #         if (is.null(y$Recovered)) {
# #             Recovered <- append(Recovered, 'NA')
# #         } else {
# #             Recovered <- append(Recovered, y$Recovered)
# #         }
# #     }
# #     
# #     df <- data.frame(cbind(Last.Update, Confirmed, Active, Deaths, Recovered))
# # 
# #     df
# # 
# # }
# # 
# # naija.data <- collect.Naija(naij.files)
# # 
# 
# 
# 
# # ===== Dirty scripts ==================
# 
# 
# # samp.one <- "./csse_covid_19_data/csse_covid_19_daily_reports/02-28-2020.csv"
# # samp.two <- "./csse_covid_19_data/csse_covid_19_daily_reports/05-17-2020.csv"
# # samp.three <- "./csse_covid_19_data/csse_covid_19_daily_reports/05-30-2020.csv"
# # samp.four <- "./csse_covid_19_data/csse_covid_19_daily_reports/05-22-2020.csv"
# # 
# # fyl <- c(samp.one, samp.two, samp.three, samp.four)
# # 
# # read.naij(samp.one)
# # 
# # 
# # z <- read.csv(samp.one, header=T, check.names = F, stringsAsFactors = F)
# # 
# # 
# # z.three <- read.csv(samp.three, header=T, check.names = F, stringsAsFactors = F)
# # 
# # names(z)[which('Last Update' == names(z))] <- 'Last_Update'
# # 
# # y <- c()
# # 
# # z <- z %>% filter(`Country/Region` == 'Nigeria')
# # 
# # z.three <- z.three %>% filter(Country_Region == 'Nigeria')
# # 
# # y <- append(y, z$Last_Update)
# # y <- append(y, z.three$Last_Update)
# # 
# # y
# 
