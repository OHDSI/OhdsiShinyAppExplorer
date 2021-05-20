# OHDSI App explorer

A meta shiny application to view shiny apps on https://data.ohdsi.org

Calls github api to generate data file. This only allows a limited number of requests without a github token.

Add your github PAT to your `.Renviron`:

    GITHUB_PAT = "gh_MySecretToken"
    
Then run the shiny app in `app.R`.

To refresh, delete the file: `studyList.rds`.

Requirements:
    
    DT
    dplyr
    shiny
    gh
    
To load environment for local use:

    install.packages("renv")
    ...
    renv::restore()
