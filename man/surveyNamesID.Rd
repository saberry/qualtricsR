\name{surveyNamesID}
\alias{surveyNamesID}
\title{
surveyNamesID
}
\description{
Provides a list of survey names and IDs for using in other functions.
}
\usage{
surveyNamesID(username, token, format)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{username}{Defaults to 'username' from qualtricsAuth function (it has to be ran and loaded first).  Otherwise, you will need to use your regular Qualtrics username (e.g., "qualtricsUser@email.address#brand").  
}
  \item{token}{Defaults to 'token' from qualtricsAuth function (it has to be ran and loaded first).  Otherwise, you will need to use your regular Qualtrics token (e.g., "tokenString").
}
  \item{format}{Valid options are "XML", "JSON", "JSONP"; default is "XML".
}
}
\details{
}
\value{
This function will return a data frame containing survey name and survey ID.
}

\author{
Seth Berry
}

\examples{
### Not Run ###

# Establish qualtricsAuth file first #

qualtricsAuth("username", "token") # You must provide these strings from Qualtrics.

load("file/location/qualtricsAuthInfo.RData")

surveyNamesID()

# Without qualtricsAuth #

surveyNamesID(username = "qualtricsUser@email.address#brand", token = "tokenString")

### End Not Run ###
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ Qualtrics }
