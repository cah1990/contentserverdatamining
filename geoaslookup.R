### geoiplookup interface for geotargeting of ipaddress names down to the AS
###
### Data used from the MaxMind open source databases via the
### geoiplookup (libgeo1) command line tool.
###
### http://www.maxmind.com/app/ip-location


geoaslookup <- function(ipaddress) {
  cmd <- sprintf("geoiplookup -f /usr/share/GeoIP/GeoIPASNum.dat %s", ipaddress)
  res <- system(cmd, intern = TRUE)
  
  parse.geoiplookup(res)
}

parse.geoiplookup <- function(x) {
  if ( grepl("can't resolve hostname", x[1]) )
    return(NULL)
  
  ## Country information:
  asnum <- sub("GeoIP ASNum Edition: [a-z|A-Z|0-9]* ", "", x[1], fixed = F)
  #country <- strsplit(country, ", ")[[1]]
  
  ## City information:
 # city <- sub("GeoIP City Edition, .*: ", "", x[2])
 # city <- strsplit(city, ", ")[[1]]
 asnum
  
#  c(asnum = country[1],
#    country_name = country[2],
#    city = city[3],
#!    city_lat = city[5],
#!    city_lon = city[6])
#c(asnum = )
}
