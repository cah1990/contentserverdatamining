content <- read.csv(file="20150723_214415_contentmap.csv", na.strings = c("","NA"), head=F,sep=",")
solution <- read.csv(file="20150723_214407_solutionmap.csv", na.strings = c("","NA"), head=F,sep=",")

#setting up some data sets
resolvedips <- data.frame(ip = NA, asn = NA)
tmpdf1 <- data.frame()

#give names to the source data columns just to be easier to work with
colnames(content) <- c("ServerVersion","RefererURL","RequestingIP")
colnames(solution) <- c("Bundle","RefererURL","RequestingIP")

merged <- merge(content,solution,by.x = "RequestingIP", by.y = "RequestingIP", all=T)

#merely reformating the output here
outputdata <- merged[c(2,4,1,3,5)]

#loading my geoip function
source("geoaslookup.R")

#get just the Requesting IPs from the data frame
myips <- as.character(outputdata$RequestingIP)

#get a list of unique IPs to make the lookup less expensive
uniqueips <- na.omit(unique(unlist(myips)))
uniqueips <- list(uniqueips)

for (i in 1:length(uniqueips[[1]])){
  resolved <- geoaslookup(uniqueips[[1]][i])
#  print(resolved)
  tmpdf1 <- data.frame(ip = uniqueips[[1]][i],asn = resolved )
  resolvedips <- rbind(resolvedips,tmpdf1)
#  print(uniqueips[[1]][i])
}
resolvedips <- na.omit(resolvedips)
#now time to merge the resolved ASN info with the list of info

finaldata <- merge(merged,resolvedips, by.x = "RequestingIP", by.y = "ip", all=T)
finaldata <- finaldata[c(2,4,1,6,3,5)]
  
#write the results to a csv
write.csv(finaldata, file = "contentDataOutput.csv")
