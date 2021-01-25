# FRED economic data
# https://fred.stlouisfed.org/

library(tidyverse)
library(quantmod)

symbols = c(
      'MORTGAGE30US', # 30yr mortgage interest rates
      'QUSR628BIS', # real residential property prices, normalized at 2010=100
      'GDP', # gross domestic product
      'GDPC1', # GDP inflation adjusted
      'CPIAUCSL', # CPI 1984=100
      'FPCPITOTLZGUSA', # inflation (cpi)
      'PCE', # personal consumption expenditure, apparently the FED's preferred inflation measure - slightly lower than normal cpi: http://www.bondeconomics.com/2014/05/primer-what-is-breakeven-inflation.html
      'USREC', # NBER recession indicator
      'PAYEMS', # employees
      'T5YIE', # breakeven inflation: see http://www.bondeconomics.com/2014/05/primer-what-is-breakeven-inflation.html
      'T10YIE', # ^
      'T30YIEM' # ^
)

FRED = symbols %>%
      map(function(symbol) {
            getSymbols(Symbols = symbol, src = 'FRED', auto.assign = FALSE) %>%
                  data.frame() %>%
                  rownames_to_column(var = 'date')
      }) %>%
      set_names(nm = symbols)

saveRDS(object = FRED, file = file.path('FRED', 'FRED.rds'))
