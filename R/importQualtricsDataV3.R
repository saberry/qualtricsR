#' Imports data from Qualtrics into R using API V3.
#' 
#' @aliases importQualtricsDataV3
#' @author Seth Berry
#' @description This function imports data from Qualtrics into R using V3 API.
#' @usage importQualtricsDataV3(token, dataCenter, surveyID)
#' @param token Your token from Qualtrics. Defaults to 'token' from
#'   qualtricsAuth function (it has to be ran and loaded first).
#' @param dataCenter The Qualtrics data center for your account. If you don't 
#' know it, you can use "ca1". If that is not your data center, it will just
#' take a little longer to get your data.
#' @param surveyID The survey ID from Qualtrics.
#' @details You can find your token and survey ID in your account
#' settings.
#' Alternatively, you can use the 'qualtricsAuth' function to store a file with
#' your username and token, and then use the 'surveyNamesID' function to pull
#' all of the survey names into your R session.
#' @return This function returns a data table from data.table.
#' @examples
#' \dontrun{
#' 
#' # Establish qualtricsAuth file first #
#' 
#' qualtricsAuth("username", "token") # You must provide these from Qualtrics.
#' 
#' load("file/location/qualtricsAuthInfo.RData")
#' 
#' dataTest <- importQualtricsDataV3(token, dataCenter, surveyID)
#' 
#' # Without qualtricsAuth #
#' 
#' dataTest <- importQualtricsDataV3(token = "yourAPIToken",
#'                             dataCenter = "ca1", surveyID = "yourSurveyID")
#' }
#' @importFrom httr add_headers
#' @importFrom httr content
#' @importFrom httr GET
#' @importFrom httr POST
#' @importFrom Hmisc label
#' @importFrom data.table fread
#' @export

importQualtricsDataV3 <- function(token, dataCenter, surveyID) {
   
   baseUrl <- paste("https://", 
                    dataCenter, 
                    ".qualtrics.com/API/v3/surveys/",
                    surveyID,
                    "/export-responses", 
                    sep = "")
   
   requestHeaders <- c("Content-Type" = "application/json", 
                       "X-API-TOKEN" = token)
   
   startSurveyDownload = POST(url = baseUrl, 
                              body = list("format" = "csv", 
                                          "compress" = "false"),
                              add_headers(.headers = requestHeaders), 
                              encode = "json")
   
   requestID <- content(startSurveyDownload)$`result`$`progressId`
   
   progressLink <- paste(baseUrl, "/", requestID,
                         sep = "")
   
   fileIDFunction <- function() {
      progressComplete <- GET(url = progressLink,
                              add_headers(.headers = requestHeaders))
      
      fileID <- content(progressComplete)$`result`$`fileId`
      
      return(fileID)
   }
   
   fileID <- fileIDFunction()
   
   while(is.null(fileID)) {
      fileID <- fileIDFunction()
   }

   downloadLink <- paste(baseUrl, "/",
                         fileID, "/file",
                         sep = "")
   
   downloadData <- GET(url = downloadLink,
                       add_headers(.headers = requestHeaders))
   
   outContent <- content(downloadData, as = "text")
   
   namesOnly <- data.table::fread(outContent, nrows = 1)
   
   out <- data.table::fread(outContent, skip = 2, header = TRUE)
   
   names(out) <- names(namesOnly)
   
   varLables <- out[1, ]
   
   label(out) <- varLables
   
   out <- out[-c(1:2), ]
   
   return(out)
}
