library(shiny)
library(dplyr)
source("utils.R")

dfLocation <- "studyList.rds"
if (file.exists(dfLocation)) {
    studyData <- readRDS(dfLocation)
} else {
    studyData <- listOhdsiStudies()
    saveRDS(studyData, dfLocation)
}


baseUrl <- "https://data.ohdsi.org/"

studyData$url <- paste0(baseUrl, studyData$path)


ui <- fluidPage(
    titlePanel("OHDSI Shiny Applications"),
    mainPanel(
       DT::dataTableOutput("studyData")
    )
)


server <- function(input, output) {
    output$studyData <- DT::renderDataTable({
      DT::datatable(studyData %>%
                      dplyr::select(c("path", "url", "description", "studyUrl", "updated")) %>%
                      dplyr::mutate(across(c("url", "studyUrl"), function(x) ifelse(x == "", "", paste0("<a href='", x,"'>", x,"</a>")))),
                    escape = FALSE)
    })
}

shinyApp(ui = ui, server = server)
