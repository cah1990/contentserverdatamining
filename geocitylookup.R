### geoiplookup interface for geotargeting of domain names
###
### Data used from the MaxMind open source databases via the
### geoiplookup (libgeo1) command line tool.
###
### http://www.maxmind.com/app/ip-location


geocitylookup <- function(domain) {
  cmd <- sprintf("geoiplookup -f /usr/share/GeoIPCity.dat %s", domain)
  res <- system(cmd, intern = TRUE)
  
  parse.geoiplookup(res)
}


parse.geocitylookup <- function(x) {
  if ( grepl("can't resolve hostname", x[1]) )
    return(NULL)
  
  ## city information:
  city <- sub("GeoIP City Edition: ", "", x[1])
  city <- strsplit(city, ", ")[[1]]
  
  ## City information:
  city <- sub("GeoIP City Edition, .*: ", "", x[2])
  city <- strsplit(city, ", ")[[1]]
  
  
  c(city_code = city[1],
    city_name = city[2],
    city = city[3],
   # city_zip = city[4]
    city_lat = city[5],
    city_lon = city[6])
}
