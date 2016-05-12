#' Imports data from Qualtrics into R.
#' 
#' @aliases importQualtricsData
#' @author Seth Berry
#' @description This function imports data from Qualtrics into R.
#' @usage importQualtricsData(username, token, surveyID, dropExtra)
#' @param username Your username from Qualtrics. Defaults to 'username' from
#'   qualtricsAuth function (it has to be ran and loaded first).
#' @param token Your token from Qualtrics. Defaults to 'token' from
#'   qualtricsAuth function (it has to be ran and loaded first).
#' @param surveyID The survey ID from Qualtrics.
#' @param dropExtra Logical (default: FALSE) indicating if you want the first 10
#'   columns dropped. This is often useless data, but sometimes you might want
#'   to keep the date.
#' @details You can find your username, token, and survey ID in your account
#' settings.
#' Alternatively, you can use the 'qualtricsAuth' function to store a file with
#' your username and token, and then use the 'surveyNamesID' function to pull
#' all of the survey names into your R session.
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
#' importQualtricsData(username, token, surveyID = "idString")
#' 
#' # Without qualtricsAuth #
#' 
#' importQualtricsData(username = "qualtricsUser@email.address#brand", 
#'                     token = "tokenString", surveyID = "idString", 
#'                     dropExtra = TRUE)
#' }
#' @export
 
importQualtricsData = function (username = username, token = token, 
                                surveyID, dropExtra = FALSE) {
  url = paste("https://survey.qualtrics.com//WRAPI/ControlPanel/api.php?Version=2.5&Request=getLegacyResponseData",
              "&User=", username,
              "&Token=", token,
              "&Format=CSV",
              "&SurveyID=", surveyID,
              "&ExportTags=1",
              sep = "")
  
  url = gsub("[@]", "%40", url)
  url = gsub("[#]", "%23", url)
  
  importQualtricsData = read.csv(url, na.strings = "", header = TRUE, 
                                 strip.white = TRUE, stringsAsFactors = FALSE)
  importQualtricsData = importQualtricsData[-1, ]
  
  if (dropExtra == TRUE) {
    importQualtricsData[-c(1:10)]
  }
    else {importQualtricsData}
}