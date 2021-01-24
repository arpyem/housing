library(tidyverse)
library(rvest)
library(lubridate)



# Parse html pages saved from 'https://www.sarasotafloridarealestate.com/market-statistics/'

parse_manatee = function(html) {
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