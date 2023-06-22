#install.packages("lidR")
#install.packages("rayshader")
#install.packages("gstat")


library(gstat)
library(lidR)
library(sf) # for working spatial class
library(raster)# for working with raster
library(rayshader) # for 3D viz

# load in lasfile
lasEI <- readLAS("2023-04-18_EI_CLEAN2.las")

#create dtm with correct coorEInate system
EI_ground <- filter_poi(lasEI, Classification == 2)

plot(EI_ground, color = "Classification")

dtmEI <- grid_terrain(EI_ground, res = 0.01, algorithm = knnidw(k = 6L, p = 2))

crs(dtmEI) = CRS("+init=epsg:28992")


#plot the dtm to visually check
par(mfrow = c(1,2))
plot(dtmEI, main = "DTM", col = height.colors(50))


# create slope map and check
slopeEI <- terrain(dtmEI, "slope", unit="degrees")
slope_sd <- sd(slopeEI[], na.rm = TRUE)
aspectEI <- terrain(dtmEI, "aspect", unit="degrees")
curvEI <- terrain(dtmEI, algorithm = "curvature", unit="degrees")

plot(curvEI)
plot(aspectEI)
plot(slopeEI)
plot(slope_sd)

# export slope file as geotiff
output_file_dtmEI <- "mapsEI/dtmEI.tif"
output_file_slopeEI <- "mapsEI/slopeEI.tif"
output_file_aspectEI <- "mapsEI/aspectEI.tif"
output_file_curvEI <- "mapsEI/curvEI.tif"

writeRaster(dtmEI, filename=output_file_dtmEI, format="GTiff", overwrite=TRUE)
writeRaster(slopeEI, filename=output_file_slopeEI, format="GTiff", overwrite=TRUE)
writeRaster(aspectEI, filename=output_file_aspectEI, format="GTiff", overwrite=TRUE)
writeRaster(curvEI, filename=output_file_curvEI, format="GTiff", overwrite=TRUE)



