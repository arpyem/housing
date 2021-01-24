# Get research data from Zillow
# https://www.zillow.com/research/data/

# paths to files are likely to change!
# most data is monthly

library(rvest)
library(tidyverse)
library(httr)

zdir = 'zillow'

# Zillow Home Value Index at country level
URL_zillow_homeValues = 'https://files.zillowstatic.com/research/public_v2/zhvi/Metro_zhvi_uc_sfrcondo_tier_0.33_0.67_sm_sa_mon.csv'
r = GET(URL_zillow_homeValues)
home_values = content(r)
saveRDS(object = home_values, file = file.path(zdir, 'home_values.rds'))

# Zillow Home Value Index at zip code level
URL_zillow_homeValues_zip = 'https://files.zillowstatic.com/research/public_v2/zhvi/Zip_zhvi_uc_sfrcondo_tier_0.33_0.67_sm_sa_mon.csv'
r = GET(URL_zillow_homeValues_zip)
home_values_zip = content(r)
saveRDS(object = home_values_zip, file = file.path(zdir, 'home_values_zip.rds'))

# Zillow Home Value Index at city level
URL_zillow_homeValues_city = 'https://files.zillowstatic.com/research/public_v2/zhvi/City_zhvi_uc_sfrcondo_tier_0.33_0.67_sm_sa_mon.csv'
r = GET(URL_zillow_homeValues_city)
home_values_city = content(r)
saveRDS(object = home_values_city, file = file.path(zdir, 'home_values_city.rds'))

# Zillow Home Value Index at county level
URL_zillow_homeValues_county = 'https://files.zillowstatic.com/research/public_v2/zhvi/County_zhvi_uc_sfrcondo_tier_0.33_0.67_sm_sa_mon.csv'
r = GET(URL_zillow_homeValues_county)
home_values_county = content(r)
saveRDS(object = home_values_county, file = file.path(zdir, 'home_values_county.rds'))

# Zillow Observed Rent Index at country level
URL_zillow_rentals = 'https://files.zillowstatic.com/research/public_v2/zori/Metro_ZORI_AllHomesPlusMultifamily_SSA.csv'
r = GET(URL_zillow_rentals)
rentals = content(r)
saveRDS(object = rentals, file = file.path(zdir, 'rentals.rds'))

# Zillow Observed Rent Index at zip code level
URL_zillow_rentals_zip = 'https://files.zillowstatic.com/research/public_v2/zori/Zip_ZORI_AllHomesPlusMultifamily_SSA.csv'
r = GET(URL_zillow_rentals_zip)
rentals_zip = content(r)
saveRDS(object = rentals_zip, file = file.path(zdir, 'rentals_zip.rds'))

# For-Sale Inventory at country level
URL_zillow_inventorySales = 'https://files.zillowstatic.com/research/public_v2/invt_fs/Metro_invt_fs_uc_sfrcondo_smoothed_month.csv'
r = GET(URL_zillow_inventorySales)
inventory_sales = content(r)
saveRDS(object = inventory_sales, file = file.path(zdir, 'inventory_sales.rds'))

rm(r)