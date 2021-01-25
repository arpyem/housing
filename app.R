library(tidyverse)
library(shiny)
library(shinyjs)
library(DT)
library(plotly)

home_values_city = readRDS(file = 'zillow/home_values_city.rds')

home_values_city$RegionName %>% unique() %>% sort()

home_value_forecast = readRDS(file = 'zillow/home_value_forecast.rds') %>%
      mutate(
            Region = factor(Region),
            RegionName = factor(Region),
            StateName = factor(StateName),
            CountyName = factor(CountyName),
            CityName = factor(CityName)
      )


home_values_smooth = readRDS('zillow/home_values_smooth.rds') %>%
      pivot_longer(cols = -RegionID:-StateName, names_to = 'date', values_to = 'value_smooth')
home_values_bottom = readRDS('zillow/home_values_bottom.rds') %>%
      pivot_longer(cols = -RegionID:-StateName, names_to = 'date', values_to = 'value_bottom') 
home_values_mid = readRDS('zillow/home_values_mid.rds') %>%
      pivot_longer(cols = -RegionID:-StateName, names_to = 'date', values_to = 'value_mid') 
home_values_top = readRDS('zillow/home_values_top.rds') %>%
      pivot_longer(cols = -RegionID:-StateName, names_to = 'date', values_to = 'value_top') 
home_values_forecast = readRDS('zillow/home_value_forecast.rds')

home_values = home_values_smooth %>%
      left_join(home_values_bottom) %>%
      left_join(home_values_mid) %>%
      left_join(home_values_top) %>%
      left_join(home_values_forecast) %>%
      mutate(
            RegionName = factor(RegionName),
            StateName = factor(StateName),
            date = ymd(date)
      )


# UI -----------------------------------------------------

ui <- fluidPage(
      
      includeCSS('srq.css'),
      
      div(
            div(
                  div(
                        selectInput(
                              inputId = 'region_home_value', 
                              label = 'Region', 
                              choices = home_values$RegionName %>% unique() %>% sort(),
                              selected = 'North Port-Sarasota-Bradenton, FL'
                        ),
                        plotlyOutput(outputId = 'p_home_value'),
                        DT::dataTableOutput(outputId = 't_home_value'),
                        class = 'card',
                        style = 'width: 75%; text-align: left'
                  ),
                  style = 'display: flex; justify-content: center'
            ),
            style = 'margin: 30px; font-size: 1.25em'
            
      )
      
)

server <- function(input, output, session) {
      
      output$p_home_value <- renderPlotly({
            p = home_values %>%
                  filter(RegionName == input$region_home_value) %>%
                  ggplot() +
                  geom_ribbon(aes(x = date, ymin = value_bottom, ymax = value_top), fill = 'dodgerblue2', alpha = 0.1) + 
                  geom_line(aes(x = date, y = value_smooth)) +
                  xlab('') +
                  scale_y_continuous(name = '', labels = scales::label_dollar()) +
                  theme_minimal()
            ggplotly(p)
      })
      
      output$t_home_value <- DT::renderDataTable({
            home_values %>%
                  select(
                        Region = RegionName, 
                        State = StateName, 
                        Date = date, 
                        Estimate = value_smooth,
                        Lower = value_bottom,
                        Upper = value_top,
                        Forecast = ForecastYoYPctChange
                  ) %>%
                  datatable(
                        options = list(pageLength = nrow(.), scroller = TRUE, scrollY = 500, scrollX = TRUE, dom = 'Bfrtip'), 
                        rownames = FALSE, 
                        filter = 'top', 
                        style = 'bootstrap', 
                        selection = 'single', 
                        extensions = c('Buttons', 'Scroller')
                  ) %>%
                  formatCurrency(columns = c('Estimate', 'Lower', 'Upper'), digits = 0) %>%
                  formatString(columns = 'Forecast', suffix = "%") 
      })
      
      output$t_homeValueForecast <- DT::renderDataTable({
            
            home_value_forecast %>%
                  select(-ForecastedDate) %>%
                  datatable(
                        options = list(pageLength = nrow(.), scroller = TRUE, scrollY = 500, scrollX = TRUE, dom = 'Bfrtip'), 
                        rownames = FALSE, 
                        colnames = c('Region type', 'Region', 'State', 'County', 'City', 'Forecasted Change (%)'),
                        filter = 'top', 
                        style = 'bootstrap', 
                        selection = 'single', 
                        extensions = c('Buttons', 'Scroller')
                  ) %>%
                  formatString(columns = 'ForecastYoYPctChange', suffix = "%") 
            
      })
      
}

shinyApp(ui, server)