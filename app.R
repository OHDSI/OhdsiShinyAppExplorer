library(shiny)
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
        dplyr::select(studyData, c("path", "url", "description", "studyUrl", "updated"))
    })
}

shinyApp(ui = ui, server = server)
