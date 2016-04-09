#' Import Advanced Format survey to Qualtrics
#' 
#' @aliases 
#' importQualtricsSurvey
#' @author 
#' Seth Berry
#' @description 
#' This function imports an Advanced Format text file from R to Qualtrics.
#' @usage importQualtricsSurvey(username, token, format, surveyName, 
#' inputFormat, fileLocation)
#' @param username
#' Your username from Qualtrics.  Defaults to 'username' from qualtricsAuth 
#' function (it has to be ran and loaded first).
#' @param token
#' Your token from Qualtrics.  Defaults to 'token' from qualtricsAuth 
#' function (it has to be ran and loaded first).
#' @param format
#' Valid options include \code{XML}, \code{JSON}, \code{JSONP}; 
#' default is \code{XML}.
#' @param surveyName
#' What you want your survey to be named within Qualtrics.
#' @param inputFormat
#' The format of the file that you are importing. 
#' Possible values include: \code{TXT}, \code{QSF}, \code{DOC}, or \code{MSQ}; 
#' "TXT" is going to be a common file type if you are creating 
#' "Advanced Format" surveys. Defaults to "TXT".
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
#' importQualtricsSurvey(surveyName = "yourSurveyName", 
#'                       fileLocation = "folder/location/yourSurveyName.txt")
#' 
#' # Without qualtricsAuth #
#' 
#' importQualtricsSurvey(username = "qualtricsUser@email.address#brand", 
#'                       token = "tokenString", format = "XML", 
#'                       surveyName = "yourSurveyName", inputFormat = "TXT", 
#'                       fileLocation = "folder/location/yourSurveyName.txt")
#' }
#' @importFrom httr POST
#' @export

importQualtricsSurvey = function (username = username, token = token, 
                                  format = "XML", surveyName, inputFormat = "TXT", 
                                  fileLocation) {
  url = paste("https://survey.qualtrics.com//WRAPI/ControlPanel/api.php?Version=2.5&Request=importSurvey",
              "&User=", username,
              "&Token=", token,
              "&Format=", format,
              "&Name=", surveyName,
              "&ImportFormat=", inputFormat,
              sep = "")

  url = gsub("[@]", "%40", url)
  
  url = gsub("[#]", "%23", url)
  
  POST(url, encode = "multipart", body = upload_file(paste(fileLocation)))
}