#' Get survey names and IDs from Qualtrics.
#' 
#' @aliases 
#' getSurveyNamesID
#' @author 
#' Seth Berry
#' @description 
#' This function brings in your survey names and IDs from Qualtrics.
#' @usage getSurveyNamesID(username, token)
#' @param username
#' Your username from Qualtrics.  
#' Defaults to 'username' from qualtricsAuth function 
#' (it has to be ran and loaded first).
#' @param token
#' Your token from Qualtrics.  
#' Defaults to 'token' from qualtricsAuth function 
#' (it has to be ran and loaded first).
#' @details 
#' You can find your username and token in your account settings. 
#' Alternatively, you can use the 'qualtricsAuth' function to store a file 
#' with your username and token.
#' @return This function returns a data frame.
#' @examples
#' \dontrun{
#' 
#' # Establish qualtricsAuth file first #
#' 
#' qualtricsAuth("username", "token") # You must provide these from Qualtrics.
#' 
#' load("file/location/qualtricsAuthInfo.RData")
#' 
#' getSurveyNamedsID(username, token)
#' 
#' # Without qualtricsAuth #
#' 
#' getSurveyNamedsID(username = "qualtricsUser@email.address#brand", 
#'                     token = "tokenString")
#' }
#' @importFrom XML xmlParse
#' @importFrom XML xpathSApply
#' @importFrom XML xmlValue
#' @importFrom httr GET
#' @export
 
getSurveyNamesID <- function(username = NULL, token = NULL) {
  
  if(all(is.null(username), is.null(token))){
    tryCatch(
      load('qualtricsAuthInfo.RData'),
      error = function(c) {
        c$message = 'No authentication info found. Please supply the RData file created by qualtricsAuth, or a username AND token.'
        stop(c)
      })
  } else if (xor(is.null(username), is.null(token))){
    stop('No authentication info found. Please supply the RData file created by qualtricsAuth, or a username AND token.')
  }
  
  baseUrl <- paste("https://", 
                   dataCenter, 
                   ".qualtrics.com/API/v3/surveys",
                   sep = "")
  
  baseUrl <- gsub("[@]", "%40", baseUrl)
  baseUrl <- gsub("[#]", "%23", baseUrl)
  
  requestHeaders <- c("Content-Type" = "application/json", 
                      "X-API-TOKEN" = token)
  
  surveynames <- GET(url = baseUrl,
                            add_headers(.headers = requestHeaders), 
                            encode = "json")
  
  surveyNamesDF <- jsonlite::fromJSON(content(surveynames, as = "text"))$result$elements
  
  nextPageFunction <- function(nextPageURL) {
    nextPageResults <- GET(url = nextPageURL,
                           add_headers(.headers = requestHeaders), 
                           encode = "json")
    
    surveyNamesDF <- jsonlite::fromJSON(content(surveynames, as = "text"))$result$elements
    
    
  }
  
  if(length(surveyNamesDF$result$nextPage) > 0) {
    
  }
  
  namesID <- data.frame(ID = xpathSApply(xmlNames, "//SurveyID", xmlValue), 
                       Name = xpathSApply(xmlNames, "//SurveyName", xmlValue))
  
  print(namesID)
}