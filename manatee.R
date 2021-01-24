library(rvest)
message(Sys.time())
file = paste0(Sys.Date(), '_srq.rds')
URL = 'https://www.sarasotafloridarealestate.com/market-statistics/'
srq = read_html(x = URL)
saveRDS(object = srq, file = file)