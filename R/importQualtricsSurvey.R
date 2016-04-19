#' Import Advanced Format survey to Qualtrics
#' 
#' @aliases 
#' importQualtricsSurvey
#' @author 
#' Seth Berry
#' @description 
#' This function imports an Advanced Format text file from R to Qualtrics.
#' @usage importQualtricsSurvey(username, token, surveyName, fileLocation)
#' @param username
#' Your username from Qualtrics.  
#' Defaults to 'username' from qualtricsAuth function 
#' (it has to be ran and loaded first).
#' @param token
#' Your token from Qualtrics.  
#' Defaults to 'token' from qualtricsAuth function 
#' (it has to be ran and loaded first).
#' @param surveyName
#' What you want your survey to be named within Qualtrics.
#' @param fileLocation Where your survey file is stored locally.
#' @details 
#' You can find your username and token in your account settings. 
#' Alternatively, you can use the 'qualtricsAuth' function to store a file
#'  with your username and token.
#' @examples
#' \dontrun{
#' 
#' # Establish qualtricsAuth file first #
#' 
#' qualtricsAuth("username", "token") # You must provide these from Qualtrics.
#' 
#' load("file/location/qualtricsAuthInfo.RData")
#' 
#' importQualtricsSurvey(username = username, token = token,
#'                       surveyName = "yourSurveyName",
#'                       fileLocation = "folder/location/yourSurveyName.txt")
#' 
#' # Without qualtricsAuth #
#' 
#' importQualtricsSurvey(username = "qualtricsUser@email.address#brand", 
#'                       token = "tokenString", surveyName = "yourSurveyName",
#'                       fileLocation = "folder/location/yourSurveyName.txt")
#' }
#' @importFrom httr POST
#' @importFrom httr upload_file
#' @export

importQualtricsSurvey = function (username = username, token = token, 
                                  surveyName, fileLocation) {
  url = paste("https://survey.qualtrics.com//WRAPI/ControlPanel/api.php?Version=2.5&Request=importSurvey",
              "&User=", username,
              "&Token=", token,
              "&Format=XML",
              "&Name=", surveyName,
              "&ImportFormat=TXT",
              sep = "")

  url = gsub("[@]", "%40", url)
  
  url = gsub("[#]", "%23", url)
  
  POST(url, encode = "multipart", body = upload_file(paste(fileLocation)))
}