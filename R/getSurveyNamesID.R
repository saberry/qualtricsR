#' Get survey names and IDs from Qualtrics.
#' 
#' @aliases 
#' getSurveyNamesID
#' @author 
#' Seth Berry
#' @description 
#' This function brings in your survey names and IDs from Qualtrics.
#' @usage getSurveyNamesID(username, token, format)
#' @param username
#' Your username from Qualtrics.  Defaults to 'username' from qualtricsAuth 
#' function (it has to be ran and loaded first).
#' @param token
#' Your token from Qualtrics.  Defaults to 'token' from qualtricsAuth 
#' function (it has to be ran and loaded first).
#' @param format
#' Valid options include \code{XML}, \code{JSON}, \code{HTML}, 
#' \code{JSON}; default is \code{CSV}.
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
#' getSurveyNamedsID()
#' 
#' # Without qualtricsAuth #
#' 
#' getSurveyNamedsID(username = "qualtricsUser@email.address#brand", 
#'                     token = "tokenString", format = "XML")
#' }
#' @importFrom XML xmlParse
#' @importFrom XML xpathSApply
#' @importFrom httr GET
#' @export
 
getSurveyNamesID = function (username = username, token = token, format = "XML") {
  url = paste("https://survey.qualtrics.com//WRAPI/ControlPanel/api.php?Version=2.5&Request=getSurveys",
              "&User=", username,
              "&Token=", token,
              "&Format=", format,
              sep = "")
  
  url = gsub("[@]", "%40", url)
  url = gsub("[#]", "%23", url)
  
  surveynames = GET(url)
  
  xmlNames = xmlParse(surveynames)
  
  namesID = data.frame(ID = xpathSApply(xmlNames, "//SurveyID", xmlValue), 
                       Name = xpathSApply(xmlNames, "//SurveyName", xmlValue))
  
  print(namesID)
}