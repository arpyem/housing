setwd("~/Projects/housing")
library(rvest)
message(Sys.time())
file = file.path('data', paste0(Sys.Date(), '_srq.rds'))
URL = 'https://www.sarasotafloridarealestate.com/market-statistics/'
srq = read_html(x = URL)
saveRDS(object = srq, file = file)