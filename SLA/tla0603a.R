# To collect and cleanse Tanium Server logs
# Read full log file into txt
data0 <- readLines("log0.txt")

# Remove common, noisy entries of Log Batch
data1 <- grepl("[00:000000:]", data0, fixed = TRUE)
data2 <- data0[!data1]

# Split the data into useful fields
timeandcode <- unlist(strsplit(data2, split = "]", fixed = TRUE))
tac2 <- grepl("[",timeandcode, fixed = TRUE)
tac3 <- timeandcode[tac2]
timethencode <- strsplit(tac3, split = "[", fixed = TRUE)


# Convert to data frame
M <- matrix(unlist(timethencode), nrow = length(timethencode),byrow = TRUE)
colnames(M) <- c("TimeStamp", "Message Code")
(output <- as.data.frame(M, stringsAfFactors = FALSE))
