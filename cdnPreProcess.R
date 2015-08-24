# To cleanse CDN Server logs
# 
#remove the next line's comment for a fresh read
data0 <- readLines("data/access.log")


#######################################################################
# Begin Solution Section
#######################################################################

#######################################################################
# # Remove common, noisy entries of Log Batch
# data1 <- grepl("[00:000000:]", data0, fixed = TRUE)
# data2 <- data0[!data1]

# Keep only the lines of interest
sol1 <- grepl("GET /files/published/", data0, fixed = T)
sol2 <- data0[sol1]
#######################################################################

#######################################################################
# # Split the data into useful fields
# timeandcode <- unlist(strsplit(data2, split = "]", fixed = TRUE))
# tac2 <- grepl("[",timeandcode, fixed = TRUE)
# tac3 <- timeandcode[tac2]
# timethencode <- strsplit(tac3, split = "[", fixed = TRUE)

#split these results into fields based on " . Setting fixed=F allows REGEX.
soldf1 <- unlist(strsplit(sol2, split = "\"", fixed = F))
#######################################################################

#######################################################################
# # Convert to data frame
# M <- matrix(unlist(timethencode), nrow = length(timethencode),byrow = TRUE)
# colnames(M) <- c("TimeStamp", "Message Code")
# (output <- as.data.frame(M, stringsAfFactors = FALSE))

sol3 <- matrix(unlist(soldf1), ncol = 8, byrow = TRUE)
colnames(sol3) <- c("TimeStamp", "Solution", "HTML Code", "Four", "Five", "Six", "Seven", "Requestor")
sol4 <- as.data.frame(sol3, stringsAfFactors = FALSE)

# Remove rows that lack requestor (code 404 168 is an indicator too)
sol5 <- subset(sol4, !(Requestor=="-"))

#######################################################################

#######################################################################
#Remove needless columns
sol6 <- sol5[c(1,2,8)]

#Trim out CDN Address from TimeStamp field
tstp1 <- as.character(sol6$TimeStamp)
tstp2 <- unlist(strsplit(tstp1, split = "[", fixed = T))
tstp3 <- strsplit(tstp2, split = "]", fixed = T)
tstp4 <- unlist(tstp3[grep("/",tstp3)])
tstp5 <- strsplit(tstp4, split = " +0000", fixed = T)
tstp6 <- tstp5[grep("/",tstp5)]

sol6$TimeStamp <- tstp6

#Trim out Solution name for Solution field
sln1 <- as.character(sol6$Solution)
sln2 <- unlist(strsplit(sln1, split = "GET /files/published/", fixed = T))
sln3 <- strsplit(sln2, split = " HTTP/[0-9].[0-9]")
sln4 <- sln3[grep("/",sln3)]

sol6$Solution <- sln4

#######################################################################
#Begin Server Version Section
#######################################################################
# Keep only the lines of interest
con1 <- grepl("GET /files/published/", data0, fixed = T)
con2 <- data0[sol1]

