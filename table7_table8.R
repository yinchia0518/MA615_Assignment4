options(stringsAsFactors = FALSE)
library(lubridate)
library(reshape2)
library(stringr)
library(plyr)

# Load data -----------------------------------------------------------------------------

raw <- read.csv("billboard.csv")
raw <- raw[, c("year", "artist.inverted", "track", "time", "date.entered", "x1st.week", "x2nd.week", "x3rd.week", "x4th.week", "x5th.week", "x6th.week", "x7th.week", "x8th.week", "x9th.week", "x10th.week", "x11th.week", "x12th.week", "x13th.week", "x14th.week", "x15th.week", "x16th.week", "x17th.week", "x18th.week", "x19th.week", "x20th.week", "x21st.week", "x22nd.week", "x23rd.week", "x24th.week", "x25th.week", "x26th.week", "x27th.week", "x28th.week", "x29th.week", "x30th.week", "x31st.week", "x32nd.week", "x33rd.week", "x34th.week", "x35th.week", "x36th.week", "x37th.week", "x38th.week", "x39th.week", "x40th.week", "x41st.week", "x42nd.week", "x43rd.week", "x44th.week", "x45th.week", "x46th.week", "x47th.week", "x48th.week", "x49th.week", "x50th.week", "x51st.week", "x52nd.week", "x53rd.week", "x54th.week", "x55th.week", "x56th.week", "x57th.week", "x58th.week", "x59th.week", "x60th.week", "x61st.week", "x62nd.week", "x63rd.week", "x64th.week", "x65th.week", "x66th.week", "x67th.week", "x68th.week", "x69th.week", "x70th.week", "x71st.week", "x72nd.week", "x73rd.week", "x74th.week", "x75th.week", "x76th.week")]

table7<-raw

# Clean the data ------------------------------------------------------------------

names(table7)[2] <- "artist"

table7$artist <- iconv(table7$artist, "MAC", "ASCII//translit")
table7$track <- str_replace(table7$track, " \\(.*?\\)", "")
names(table7)[-(1:5)] <- str_c("wk", 1:76)
table7 <- arrange(raw, year, artist, track)

long_name <- nchar(table7$track) > 20
table7$track[long_name] <- paste0(substr(table7$track[long_name], 0, 20), "...")

# Convert to tidy data ------------------------------------------------------------------

table7.1 <- table7%>%gather(key="week",value="rank",-year,-artist,-track,-time,-date.entered)

table7.2<- table7.1%>%arrange(artist,track)

table7.3<- table7.2%>%filter(!is.na(rank))

table7.4 <- table7.3 %>%   separate(week, c("wk", "week"), sep = 2)

table7.5 <- table7.4 %>% select(- wk)

table7.6<- table7.5%>% select(year,artist,time,track,date.entered,week,rank)

table8 <- table7.6

