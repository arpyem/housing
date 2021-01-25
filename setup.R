library(tidyverse)
library(rvest)
library(lubridate)


# Convert text-formatted numbers into numeric objects
# Double check output if coercion warnings are thrown

to_numeric = function(x) {
      val = gsub(pattern = '[^0-9.]', replacement = '', x = x)
      val = as.numeric(val)
      return(val)
}


# Get Zillow estimate for 1064 N Tamiami Trl (by default, or specify other Zillow property)
# Check css/xpath and number format if errors

get_1064 = function(url = 'https://www.zillow.com/homedetails/1064-N-Tamiami-Trl-UNIT-1625-Sarasota-FL-34236/87671715_zpid/', original_price = 395000) {
      html = xml2::read_html(url)
      zestimate = html %>%
            html_nodes('.zestimate-value') %>%
            html_text(trim = TRUE) %>%
            gsub(pattern = '[^0-9.]', replacement = '', x = .) %>%
            as.numeric()
}


# Parse html pages saved from 'https://www.sarasotafloridarealestate.com/market-statistics/'

parse_srq = function(html) {
      html %>%
            html_nodes('.si-market-stat__box') %>%
            map(function(box) {
                  
                  # Specific location (county, city)
                  location = box %>%
                        html_nodes('.si-market-stat__title') %>%
                        html_text(trim = TRUE) %>%
                        str_split(pattern = '/')
                  
                  # Location name
                  name = location %>%
                        pluck(1) %>%
                        unlist() %>%
                        gsub(pattern = 'trends', replacement = '', ignore.case = TRUE) %>%
                        str_trim()
                  
                  # Date of statistics
                  date = location %>%
                        pluck(2) %>%
                        unlist() %>%
                        gsub(pattern = 'trends', replacement = '', ignore.case = TRUE) %>%
                        str_trim()
                  
                  # Summary stats
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
                  
                  # Details
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
                  
                  # Return list of results
                  result <- list(
                        name = name,
                        date = date,
                        top = top,
                        section = section
                  )
                  
                  return(result)
            }) %>%
            set_names(nm = pluck(x = ., i = 'name'))
}