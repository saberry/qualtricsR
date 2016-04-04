\name{exportQualtricsData}
\alias{exportQualtricsData}
\title{
exportQualtricsData
}
\description{
Exports data from Qualtrics into R.
}
\usage{
exportQualtricsData(username, token, format, surveyID, dropExtra = FALSE)
}

\arguments{
  \item{username}{Your username from Qualtrics.  Defaults to 'username' from qualtricsAuth function (it has to be ran and loaded first).
}
  \item{token}{Your token from Qualtrics.  Defaults to 'token' from qualtricsAuth function (it has to be ran and loaded first).
}
  \item{format}{Valid options include "XML", "CSV", "HTML", "JSON"; default is "CSV".
}
  \item{surveyID}{The survey ID from Qualtrics.
}
  \item{dropExtra}{Logical (default: FALSE) indicating if you want the first 10 columns dropped. This is often useless data, but sometimes you might want to keep the date.
}
}
\details{You can find your username, token, and survey ID in your account settings. Alternatively, you can use the 'qualtricsAuth' function to store a file with your username and token, and then use the 'surveyNamesID' function to pull all of the survey names into your R session.
}
\value{Returns a data frame.
}
\references{
}
\author{Seth Berry
}
\note{
}

\seealso{
}
\examples{

### Not Run ###

# Establish qualtricsAuth file first #

qualtricsAuth("username", "token") # You must provide these strings from Qualtrics.

load("file/location/qualtricsAuthInfo.RData")

exportQualtricsData(surveyID = "idString")

# Without qualtricsAuth #

exportQualtricsData(username = "qualtricsUser@email.address#brand", 
                    token = "tokenString", format = "CSV", 
                    surveyID = "idString", dropExtra = TRUE)

}
\keyword{ Qualtrics }