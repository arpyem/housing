library(rvest)
library(tidyverse)

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

srq %>%
      html_nodes('.si-market-stat__box') %>%
      html_nodes('.si-market-stat__title') %>%
      html_text(trim = TRUE) %>%
      str_split(pattern = '/') %>%
      pluck(1) %>%
      unlist() %>%
      gsub(pattern = 'trends', replacement = '', ignore.case = TRUE) %>%
      str_trim()


srq %>%
      html_nodes('.si-market-stat__title') %>%
      html_text(trim = TRUE) %>%
      str_split(pattern = '/') %>%
      pluck(1) %>%
      unlist() %>%
      gsub(pattern = 'trends', replacement = '', ignore.case = TRUE) %>%
      str_trim()











