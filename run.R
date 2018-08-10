library(raster)
windspeed <- raster("data/10m_wind_speed_19950101.grib")
# class       : RasterLayer 
# dimensions  : 241, 480, 115680  (nrow, ncol, ncell)
# resolution  : 0.75, 0.75  (x, y)
# extent      : -0.375, 359.625, -90.375, 90.375  (xmin, xmax, ymin, ymax)
# coord. ref. : +proj=longlat +a=6367470 +b=6367470 +no_defs
plot(windspeed)


load("capitals.RData")
head(capitals)
# ID iso3   country  capital   long    lat
# 1  1  AUS Australia Canberra 149.13 -35.31
# 2  2  AUT   Austria   Vienna  16.37  48.22
# 3  3  BEL   Belgium Brussels   4.33  50.83
# 4  4  BGR  Bulgaria    Sofia  23.31  42.69
# 5  5  BRA    Brazil Brasilia -47.91 -15.78
# 6  6  CAN    Canada   Ottawa -75.71  45.42

library(sf)
capitals_sf <- st_as_sf(capitals, coords = c("long", "lat"), crs = 4326)
capitals_sf
# Simple feature collection with 40 features and 4 fields
# geometry type:  POINT
# dimension:      XY
# bbox:           xmin: -99.14 ymin: -35.31 xmax: 149.13 ymax: 60.17
# epsg (SRID):    4326
# proj4string:    +proj=longlat +datum=WGS84 +no_defs
# First 10 features:
#   ID iso3        country  capital              geometry
# 1   1  AUS      Australia Canberra POINT (149.13 -35.31)
# 2   2  AUT        Austria   Vienna   POINT (16.37 48.22)
# 3   3  BEL        Belgium Brussels    POINT (4.33 50.83)
# 4   4  BGR       Bulgaria    Sofia   POINT (23.31 42.69)
# 5   5  BRA         Brazil Brasilia POINT (-47.91 -15.78)
# 6   6  CAN         Canada   Ottawa  POINT (-75.71 45.42)
# 7   7  CHN          China  Beijing   POINT (116.4 39.93)
# 9   8  CYP         Cyprus  Nicosia   POINT (33.38 35.16)
# 11  9  CZE Czech Republic   Prague   POINT (14.43 50.08)
# 12 10  DEU        Germany   Berlin   POINT (13.38 52.52)
newcrs <- crs(windspeed, asText = TRUE)
capitals_tf <- st_transform(capitals_sf, crs = newcrs)
capitals_tf
# Simple feature collection with 40 features and 4 fields
# geometry type:  POINT
# dimension:      XY
# bbox:           xmin: -99.14 ymin: -35.31 xmax: 149.13 ymax: 60.17
# epsg (SRID):    NA
# proj4string:    +proj=longlat +a=6367470 +b=6367470 +no_defs
# First 10 features:
#   ID iso3        country  capital              geometry
# 1   1  AUS      Australia Canberra POINT (149.13 -35.31)
# 2   2  AUT        Austria   Vienna   POINT (16.37 48.22)
# 3   3  BEL        Belgium Brussels    POINT (4.33 50.83)
# 4   4  BGR       Bulgaria    Sofia   POINT (23.31 42.69)
# 5   5  BRA         Brazil Brasilia POINT (-47.91 -15.78)
# 6   6  CAN         Canada   Ottawa  POINT (-75.71 45.42)
# 7   7  CHN          China  Beijing   POINT (116.4 39.93)
# 9   8  CYP         Cyprus  Nicosia   POINT (33.38 35.16)
# 11  9  CZE Czech Republic   Prague   POINT (14.43 50.08)
# 12 10  DEU        Germany   Berlin   POINT (13.38 52.52)

plot(capitals_tf, col = "black", add = T)

library(sp)
capitals_sp <- as(capitals_sf, "Spatial")
capitals_stp <- sp::spTransform(capitals_sp, CRSobj = crs(windspeed))
plot(capitals_stp, col = "red", add = T)
