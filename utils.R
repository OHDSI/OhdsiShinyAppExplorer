
getOhdsiStudyInfo <- function(studyName) {
  res <- NULL
  tryCatch({
    res <- gh::gh(paste("GET /repos/ohdsi-studies/", studyName, sep = ""), .token=Sys.getenv("GITHUB_PAT"))
  }, error = function(e) {

  })
  return(res)
}

listOhdsiStudies <- function() {
  subDir <- gh::gh("GET /repos/ohdsi/ShinyDeploy/git/trees/master", .token = Sys.getenv("GITHUB_PAT"))
  folders <- data.frame()
  for (f in 1:length(subDir$tree)) {
    if (subDir$tree[[f]]$type == "tree") {
      df <- data.frame(subDir$tree[[f]])
      info <- getOhdsiStudyInfo(subDir$tree[[f]]$path)

      if (is.null(info)) {
        df$updated <- ""
        df$description <- ""
        df$studyUrl <- ""
      } else {
        df$updated <- info$updated_at
        df$studyUrl <- paste("https://github.com/ohdsi-studies/", subDir$tree[[f]]$path, sep = "")
        df$description <- if(!is.null(info$description)) info$description else ""
      }
      folders <- rbind(folders, df)
    }
  }
  return(folders)
}
