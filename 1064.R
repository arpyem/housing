# Zillow data for our property

library(rvest)

# 1064 N Tamiami Trl
URL = 'https://www.zillow.com/homedetails/1064-N-Tamiami-Trl-UNIT-1625-Sarasota-FL-34236/87671715_zpid/'
original_price = 395000

html = read_html(URL)
zestimate = html %>%
      html_nodes(xpath = '//*[@id="ds-container"]/div[3]/div[2]/div/p/span[3]/span[2]/span[2]') %>%
      html_text(trim = TRUE) %>%
      gsub(pattern = '[^0-9.]', replacement = '', x = .) %>%
      as.numeric()


html %>%
      html_nodes('.zestimate-value') %>%
      html_text(trim = TRUE) %>%
      gsub(pattern = '[^0-9.]', replacement = '', x = .) %>%
      as.numeric()
