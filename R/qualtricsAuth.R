# @export
qualtricsAuth = function (username, token, file = "qualtricsAuthInfo.RData") {
  save(username, token, file = file)
  load("qualtricsAuthInfo.RData")
}