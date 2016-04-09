#' Save Qualtrics Authentication Info.
#' 
#' @aliases 
#' qualtricsAuth
#' @author 
#' Seth Berry
#' @description 
#' This function stores your username and token in a file for easier access.
#' @usage qualtricsAuth(username, token, file)
#' @param username
#' Your username from Qualtrics.  Defaults to 'username' from qualtricsAuth 
#' function (it has to be ran and loaded first).
#' @param token
#' Your token from Qualtrics.  Defaults to 'token' from qualtricsAuth 
#' function (it has to be ran and loaded first).
#' @param file
#' Where you want the .RData file to be stored and what you want it to be names.
#' Defaults to "qualtricsAuthInfo.RData"
#' @details 
#' You can find your username and token in your account settings. 
#' @return This function creates an .RData file in you working directory.
#' @examples
#' \dontrun{
#' 
#' qualtricsAuth(qualtricsUser@email.address#brand, tokenString, 
#'               file = "qualtricsAuthInfo.RData")
#' }
#' @export
qualtricsAuth = function (username, token, file = "qualtricsAuthInfo.RData") {
  save(username, token, file = file)
}