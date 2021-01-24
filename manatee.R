library(rvest)
etwd("~/Projects/housing")
message(Sys.time())
file = file.path('data', paste0(Sys.Date(), '_srq.html'))
URL = 'https://www.sarasotafloridarealestate.com/market-statistics/'
srq = read_html(URL)
xml2::write_xml(srq, file)