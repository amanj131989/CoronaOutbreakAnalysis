## ---------------------------
##
## Script name: UI File
##
## Purpose of script:
##
## Author: Amandeep Jiddewar
##
## Date Created: 2020-03-14
##
## "We are drowning in information, while starving for wisdom - E. O. Wilson"
##
## ---------------------------


library(tidyverse)
library(prophet)
library(shiny)
library(dygraphs)
library(shinycssloaders)
library(shinydashboard)
library(DT)

source("model_helper.R")
source("utility.R")

lst_countries <- get_list_of_countries()

# Define UI for application that draws a histogram
fluidPage(
  
  title = "COVID-19 Cases",
  
  titlePanel("COVID 19 Cases"),
  
  HTML(
  str_glue({"The document shows country-wise confirmed, deaths, and recovered cases. 
  The model <a href='https://facebook.github.io/prophet/docs/quick_start.html#r-api'>forecasts</a> 
  the next seven days of expected cases. 
  Facebook's prophet is used to create the models below. The rate of growth/change is the 
  second-highest rate of change in the window of the last five days.  There are many variables, 
  such as travel bans, lockdowns,  quarantines, etc. This is a univariate forecasting model. 
  I have only considered the previously reported cases. The model is created for my learning 
  and should not be taken as an authentic source. It does a pretty good job of predicting the 
  next 2-3 days but fails when it comes to looking far ahead in the future. 
  Here is a GitHub code for the reference. 
  <a href='https://github.com/amandeepfj/CoronaOutbreakAnalysis/tree/master/R'>Code</a>"})),
  
  br(),br(),
  
  selectInput("country", label = "Country",
              choices = lst_countries, selected = "Iran"),
  
  
  hr(),
  fluidRow(
    column(
      width = 4,
      h2("Confirmed Cases"),
      br(),
      dataTableOutput("dt_predictions_confirmed")
    ),
    column(
      width = 8,
      
      br(),br(),br(),
      
      htmlOutput("commentary_confirmed"),
      
      br(),br(),
      
      dygraphOutput("forecasts_confirmed") %>% withSpinner(),
    ),
  ),
  
  
  
  hr(),
  fluidRow(
    column(
      width = 4,
      h2("Death Cases"),
      br(),
      dataTableOutput("dt_predictions_deaths")
    ),
    column(
      width = 8,
      
      br(),br(),br(),
      
      htmlOutput("commentary_deaths"),
      
      br(),br(),
      dygraphOutput("forecasts_deaths") %>% withSpinner(),
      #plotOutput("forecast_components") %>% withSpinner(),
    ),
  ),
  
  
  hr(),
  fluidRow(
    column(
      width = 4,
      h2("Recovered Cases"),
      br(),
      dataTableOutput("dt_predictions_recovered")
    ),
    column(
      width = 8,
      
      br(),br(),br(),
      
      htmlOutput("commentary_recovered"),
      
      br(),br(),
      dygraphOutput("forecasts_recovered") %>% withSpinner(),
    ),
  ),
  
  hr(),
  HTML("<ul><b>Data sources</b>
          <li> <a>https://www.kaggle.com/sudalairajkumar/novel-corona-virus-2019-dataset</a>
          <li> <a>https://github.com/CSSEGISandData/COVID-19/tree/master/csse_covid_19_data</a>
        </ul>"),
  
  hr(),
  includeHTML("footer.html"),
  br(),
)