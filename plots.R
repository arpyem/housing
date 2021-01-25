source('setup.R')

'data' %>%
      file.path(list.files(.)) %>%
      map(function(x) {
            date = x %>%
                  str_split(pattern = "/") %>%
                  pluck(2) %>%
                  str_split(pattern = "_") %>%
                  pluck(1) %>%
                  unlist() %>%
                  as_date()
            html = read_html(x)
            parse_srq(html)
      })



