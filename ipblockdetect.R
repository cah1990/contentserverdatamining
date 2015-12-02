# To cleanse CDN Server logs
# Chris Hughes
# 
#remove the next line's comment for a fresh read
data0 <- read.csv("results/ServerVersionOutput.csv")

#loading my geoip function
source("geoaslookupcountry.R")

#######################################################################
# Begin Merging & GeoReferencing
#######################################################################

# Make certain we know the column names
# colnames(solution) <- c("TimeStamp", "Solution", "Requester")
# colnames(serverversion) <- c("TimeStamp", "TaniumServerVersion", "Referer", "Requester")

#setting up some data sets
 resolvedverips <- data.frame(ip = NA, Country = NA)
 resolvedsolips <- data.frame(ip = NA, Country = NA)
 tmpdf1 <- data.frame()
# tmpdf2 <- data.frame()


#Geo-Reference the ServerVersion IPs
#get just the Requesting IPs from the data frame
myverips <- as.character(data0$Requester)
# 
# #get a list of unique IPs to make the lookup less expensive
uniqueverips <- na.omit(unique(unlist(myverips)))
uniqueverips <- list(uniqueverips)
# 
   for (i in 1:length(uniqueverips[[1]])){
     resolvedver <- geoaslookupcountry(uniqueverips[[1]][i])
#     print(resolvedver)
     tmpdf1 <- data.frame(ip = uniqueverips[[1]][i],Country = resolvedver )
     resolvedverips <- rbind(resolvedverips,tmpdf1)
#     #print(uniqueverips[[1]][i])
   }

#This gets ASN
# for (i in 1:length(uniqueverips[[1]])){
#   resolvedver <- geoaslookup(uniqueverips[[1]][i])
#   tmpdf1 <- data.frame(ip = uniqueverips[[1]][i],ASN = resolvedver )
#   resolvedverips <- rbind(resolvedverips,tmpdf1)
#   #print(uniqueverips[[1]][i])
# }

# 
# resolvedverips <- na.omit(resolvedverips)

#now time to merge the resolved ASN info with the list of info
#finalverdata <- merge(serverversion,resolvedverips, by.x = "Requester", by.y = "ip", all=T)
#Reorder output columns
#finalverdata <- finalverdata[c(2,3,1,5,4)]
#Get rid of list formatting to enable writing to file
#finalverdata <- data.frame(lapply(finalverdata, as.character),stringsAsFactors = T)
#write the results to a csv
write.csv(resolvedverips, file = "results/AccessingIPCountries.csv")
