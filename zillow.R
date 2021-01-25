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



# Home Value ----------------------------------------------------

# Metro/US ----

# Smoothed
URL = 'https://files.zillowstatic.com/research/public_v2/zhvi/Metro_zhvi_uc_sfrcondo_tier_0.33_0.67_sm_sa_mon.csv'
r = GET(URL)
home_values_smooth = content(r)
saveRDS(object = home_values_smooth, file = file.path(zdir, 'home_values_smooth.rds'))

# Bottom tier
URL = 'https://files.zillowstatic.com/research/public_v2/zhvi/Metro_zhvi_uc_sfrcondo_tier_0.0_0.33_sm_sa_mon.csv'
r = GET(URL)
home_values_bottom = content(r)
saveRDS(object = home_values_bottom, file = file.path(zdir, 'home_values_bottom.rds'))

# Mid tier
URL = 'https://files.zillowstatic.com/research/public_v2/zhvi/Metro_zhvi_uc_sfrcondo_tier_0.33_0.67_raw_mon.csv'
r = GET(URL)
home_values_mid = content(r)
saveRDS(object = home_values_mid, file = file.path(zdir, 'home_values_mid.rds'))

# Top tier
URL = 'https://files.zillowstatic.com/research/public_v2/zhvi/Metro_zhvi_uc_sfrcondo_tier_0.67_1.0_sm_sa_mon.csv'
r = GET(URL)
home_values_top = content(r)
saveRDS(object = home_values_top, file = file.path(zdir, 'home_values_top.rds'))






# City ----


# Smoothed - city
URL = 'https://files.zillowstatic.com/research/public_v2/zhvi/City_zhvi_uc_sfrcondo_tier_0.33_0.67_sm_sa_mon.csv'
r = GET(URL)
home_values_city = content(r)
saveRDS(object = home_values_city, file = file.path(zdir, 'home_values_city.rds'))

# High tier - city
URL = 'https://files.zillowstatic.com/research/public_v2/zhvi/City_zhvi_uc_sfrcondo_tier_0.67_1.0_sm_sa_mon.csv'
r = GET(URL)
home_values_city_high = content(r)
saveRDS(object = home_values_city_high, file = file.path(zdir, 'home_values_city_high.rds'))

# Low tier - city
URL = 'https://files.zillowstatic.com/research/public_v2/zhvi/City_zhvi_uc_sfrcondo_tier_0.0_0.33_sm_sa_mon.csv'
r = GET(URL)
home_values_city_low = content(r)
saveRDS(object = home_values_city_low, file = file.path(zdir, 'home_values_city_low.rds'))



# Rent ----------------------------------------------------------------------------

# Zillow Observed Rent Index at zip code level
URL_zillow_rentals_zip = 'https://files.zillowstatic.com/research/public_v2/zori/Zip_ZORI_AllHomesPlusMultifamily_SSA.csv'
r = GET(URL_zillow_rentals_zip)
rentals_zip = content(r)
saveRDS(object = rentals_zip, file = file.path(zdir, 'rentals_zip.rds'))



# Inventory --------------------------------------------------------------

# All country/metro level

# For sale inventory - weekly
URL = 'https://files.zillowstatic.com/research/public_v2/invt_fs/Metro_invt_fs_uc_sfrcondo_raw_week.csv'
r = GET(URL)
inventory = content(r)
saveRDS(object = inventory, file = file.path(zdir, 'inventory.rds'))

# Newly listed - weekly
URL = 'https://files.zillowstatic.com/research/public_v2/new_pending/Metro_new_pending_uc_sfrcondo_raw_weekly.csv'
r = GET(URL)
newly_listed = content(r)
saveRDS(object = newly_listed, file = file.path(zdir, 'newly_listed.rds'))

# Days to pending - mean, weekly
URL = 'https://files.zillowstatic.com/research/public_v2/mean_doz_pending/Metro_mean_doz_pending_uc_sfrcondo_raw_weekly.csv'
r = GET(URL)
days_pending_mean = content(r)
saveRDS(object = days_pending_mean, file = file.path(zdir, 'days_pending_mean.rds'))

# Days to pending - median, weekly
URL = 'https://files.zillowstatic.com/research/public_v2/med_doz_pending/Metro_med_doz_pending_uc_sfrcondo_raw_weekly.csv'
r = GET(URL)
days_pending_median = content(r)
saveRDS(object = days_pending_median, file = file.path(zdir, 'days_pending_median.rds'))

# Median sale price - weekly
URL = 'https://files.zillowstatic.com/research/public_v2/median_sale_price/Metro_median_sale_price_uc_SFRCondo_raw_week.csv'
r = GET(URL)
sale_price = content(r)
saveRDS(object = sale_price, file = file.path(zdir, 'sale_price.rds'))

# Mean price cut - weekly
URL = 'https://files.zillowstatic.com/research/public_v2/mean_listings_price_cut_perc/Metro_mean_listings_price_cut_perc_uc_sfrcondo_raw_week.csv'
r = GET(URL)
price_cut_mean = content(r)
saveRDS(object = price_cut_mean, file = file.path(zdir, 'price_cut_mean.rds'))

# Median price cut - weekly
URL = 'https://files.zillowstatic.com/research/public_v2/med_listings_price_cut_perc/Metro_med_listings_price_cut_perc_uc_sfrcondo_raw_week.csv'
r = GET(URL)
price_cut_median = content(r)
saveRDS(object = price_cut_median, file = file.path(zdir, 'price_cut_median.rds'))








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

# For-Sale Inventory at country level
URL_zillow_inventorySales = 'https://files.zillowstatic.com/research/public_v2/invt_fs/Metro_invt_fs_uc_sfrcondo_smoothed_month.csv'
r = GET(URL_zillow_inventorySales)
inventory_sales = content(r)
saveRDS(object = inventory_sales, file = file.path(zdir, 'inventory_sales.rds'))



URL = 'https://files.zillowstatic.com/research/public_v2/zhvf/AllRegionsForPublic.csv'
r = GET(URL)
home_value_forecast = content(r)
saveRDS(object = home_value_forecast, file = file.path(zdir, 'home_value_forecast.rds'))




rm(r)