#' Exports data from Qualtrics into R.
#' 
#' @aliases 
#' exportQualtricsData
#' @author 
#' Seth Berry
#' @description 
#' This function exports data from Qualtrics 
#' into R.
#' @usage exportQualtricsData(username = username, token = token, format = "CSV",
#' surveyID, dropExtra = FALSE)
#' @param username
#' Your username from Qualtrics.  Defaults to 'username' from qualtricsAuth 
#' function (it has to be ran and loaded first).
#' @param token
#' Your token from Qualtrics.  Defaults to 'token' from qualtricsAuth 
#' function (it has to be ran and loaded first).
#' @param format
#' Valid options include \code{XML}, \code{CSV}, \code{HTML}, 
#' \code{JSON}; default is \code{CSV}.
#' @param surveyID
#' The survey ID from Qualtrics.
#' @param dropExtra
#' Logical (default: FALSE) indicating if you want the first 10 
#' columns dropped. This is often useless data, but sometimes you 
#' might want to keep the date.
#' @details 
#' You can find your username, token, and survey ID in your account settings. 
#' Alternatively, you can use the 'qualtricsAuth' function to store a file 
#' with your username and token, and then use the 'surveyNamesID' function 
#' to pull all of the survey names into your R session.
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
#' exportQualtricsData(surveyID = "idString")
#' 
#' # Without qualtricsAuth #
#' 
#' exportQualtricsData(username = "qualtricsUser@email.address#brand", 
#'                     token = "tokenString", format = "CSV", 
#'                     surveyID = "idString", dropExtra = TRUE)
#' }
#' @export
 
exportQualtricsData = function (username = username, token = token, 
                                format = "CSV", surveyID, dropExtra = FALSE) {
  url = paste("https://survey.qualtrics.com//WRAPI/ControlPanel/api.php?Version=2.5&Request=getLegacyResponseData",
              "&User=", username,
              "&Token=", token,
              "&Format=", format,
              "&SurveyID=", surveyID,
              "&ExportTags=1",
              sep = "")
  
  url = gsub("[@]", "%40", url)
  url = gsub("[#]", "%23", url)
  
  exportQualtricsData = read.csv(url)
  exportQualtricsData = exportQualtricsData[-1, ]
  
  if (dropExtra == TRUE) {
    exportQualtricsData[-c(1:10)]
  }
    else {exportQualtricsData}
}