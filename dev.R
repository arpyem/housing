library(rvest)
library(tidyverse)
library(httr)

URL = 'https://www.sarasotafloridarealestate.com/market-statistics/'

srq = read_html(x = URL)

srq %>%
      html_nodes('.si-market-stat__box') %>%
      map(function(box) {
            
            
            
            location = box %>%
                  html_nodes('.si-market-stat__title') %>%
                  html_text(trim = TRUE)

            top_label = box %>%
                  html_nodes('.si-market-stat__top-label') %>%
                  html_text(trim = TRUE)
            top_value = box %>%
                  html_nodes('.si-market-stat__top-value') %>%
                  html_text(trim = TRUE)
            top = data.frame(
                  label = top_label,
                  value = top_value
            )
            
            section = box %>%
                  html_nodes('.si-market-stat__section div') %>%
                  map_df(function(section) {
                        label = section %>%
                              html_node('span') %>%
                              html_text(trim = TRUE)
                        value = section %>%
                              html_node('strong') %>%
                              html_text(trim = TRUE)
                        data.frame(
                              label = label,
                              value = value
                        )
                  })



            list(
                  location = location,
                  top = top,
                  section = section
            )
      })



html %>%
      html_nodes('.si-market-stat__title') %>%
      html_text(trim = TRUE) %>%
      str_split(pattern = '/') %>%
      pluck(1) %>%
      unlist() %>%
      gsub(pattern = 'trends', replacement = '', ignore.case = TRUE) %>%
      str_trim()




list.files('data')

html = read_html("data/2021-01-24_srq.html")

manatee = html %>%
   html_nodes('.si-market-stat__box') %>%
   map(function(box) {
      
      location = box %>%
         html_nodes('.si-market-stat__title') %>%
         html_text(trim = TRUE) %>%
         str_split(pattern = '/')
      
      name = location %>%
         pluck(1) %>%
         unlist() %>%
         gsub(pattern = 'trends', replacement = '', ignore.case = TRUE) %>%
         str_trim()
      
      date = location %>%
         pluck(2) %>%
         unlist() %>%
         gsub(pattern = 'trends', replacement = '', ignore.case = TRUE) %>%
         str_trim()
      
      top_label = box %>%
         html_nodes('.si-market-stat__top-label') %>%
         html_text(trim = TRUE)
      top_value = box %>%
         html_nodes('.si-market-stat__top-value') %>%
         html_text(trim = TRUE)
      top = data.frame(
         label = top_label,
         value = top_value
      )
      
      section = box %>%
         html_nodes('.si-market-stat__section div') %>%
         map_df(function(section) {
            label = section %>%
               html_node('span') %>%
               html_text(trim = TRUE)
            value = section %>%
               html_node('strong') %>%
               html_text(trim = TRUE)
            data.frame(
               label = label,
               value = value
            )
         })
      
      list(
         name = name,
         date = date,
         top = top,
         section = section
      )
   }) %>%
   set_names(nm = pluck(x = ., i = 'name'))

manatee %>%
   pluck('name')





test = read_html('https://www.sarasotafloridarealestate.com/idx/results/?searchid=85533')

test %>% html_nodes('.si-listings-column--right') 

test %>% html_nodes('.si-listing__price-title')
test %>%
      html_nodes('.si-listing__content')
test %>% html_nodes(xpath = '#lw8707006 > div > div.si-listings-column--right > div')



test = html_session('https://www.sarasotafloridarealestate.com/idx/results/?searchid=85533')
form = html_form(test)[[1]]
form = set_values(test)


html_form(test)


test = httr::POST(
      url = 'https://www.sarasotafloridarealestate.com/property-search/res/includes/search_application/get_listings.asp', 
      body = list(pageSize = 343)
)


test = httr::POST(
      url = 'https://www.sarasotafloridarealestate.com/idx/results/?searchid=85533', 
      body = list(pageSize = 343)
)


test = GET(
      url = 'https://www.sarasotafloridarealestate.com/property-search/res/includes/search_application/get_listings.asp',
      add_headers(
            Referer = 'https://www.sarasotafloridarealestate.com/idx/results/?searchid=85533',
            `X-Requested-With` = 'XMLHttpRequest'
      ),
      query = list(
            
      )
)




{"searchType":"list","adminUserId":608,"clientSearch":{"id":"281521689","active":false,"type":1,"featuredFirst":false},"favorite":false,"mlsRegionId":29,"mlsRegions":"29","listingClass":1,"listingStatus":"Active,Pending","quickSearch":{"mls":"","address":"","type":-1},"search":{"acreage":{"max":"","min":""},"age":{"min":0},"baths":{"max":100,"min":""},"beds":{"max":100,"min":""},"daysOnMarket":"","extra":{"basement":"","construction":"","energy":"","exterior":"","fencing":"","interior":"","lots":"","owner":"","stories":"","styles":"","searchFeatures":""},"filter":{"excludeMLSIds":"","includeAgentIds":"","includeMLSIds":"","includeOfficeIds":""},"flags":{"acrossStreetFromOcean":false,"bayFront":false,"beachfront":false,"equestrian":false,"foreclosure":false,"golfCourseFront":false,"gulfFront":false,"hdPhotos":false,"hudHome":false,"mbOnFirstFloor":false,"newConstruction":false,"oceanFront":false,"openHouse":false,"pool":false,"reo":false,"shortSale":false,"singleLevel":false,"spa":false,"viewScenic":false,"virtualTour":false,"waterFront":false,"woodedLot":false,"hasPhoto":false},"garageCap":{"min":""},"hoaFees":{"max":"","min":""},"supportedListTypes":"1,3,4,8","listType":"1","listTypeDescrip":"","location":{"areas":"","cities":"","condoProjectNames":"","counties":"","schools":"","states":"","subAreas":"","subDivisions":"","townships":"","zips":"","elementarySchools":"","middleSchools":"","highSchools":"","juniorHighSchools":""},"map":{"eastLong":"","northLat":"","searchRegion":"POLYGON ((-82.552042007446289 27.34569656020296, -82.531013488769531 27.344019284933722, -82.5307559967041 27.327168883991792, -82.557363510131836 27.324423779690932, -82.552042007446289 27.34569656020296))","southLat":"","westLong":"","centerLat":27.335,"centerLong":-82.5433,"zoomLevel":11},"alert":{"startDate":"","priceChangeDate":""},"price":{"max":"","min":""},"priceReductionPercentage":"","soldDays":"","openHouseDays":0,"openHouseType":0,"priceChangeDays":0,"sortBy":"m.DateListed DESC","sqft":{"max":"","min":""},"yearBuilt":{"max":"","min":""},"offset":{"pageSize":12,"pageNumber":1,"listingId":""},"statusActivityDays":""},"searchId":85533,"userId":""}


https://www.sarasotafloridarealestate.com/property-search/res/includes/search_application/get_listings.asp














url = 'https://www.sarasotafloridarealestate.com/downtown-sarasota/'
test = read_html(url)
test %>%
      html_nodes('.si-listing__price-title')







df %>%
      filter(RegionName == '34236') %>%
      pivot_longer(cols = -RegionID:-CountyName, names_to = 'date', values_to = 'value') %>%
      mutate(date = ymd(date)) %>%
      ggplot(aes(x = date, y = value)) +
      geom_line() +
      theme_minimal()


df = readRDS('zillow/home_values_city.rds')

df %>%
      filter()

