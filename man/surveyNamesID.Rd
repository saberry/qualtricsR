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
  \item{username}{If you have ran the 'qualtricsAuth' function, then you can simply use 'username' here. Otherwise, you will need to use your regular Qualtrics username (e.g., "qualtricsUser@email.address#brand").
}
  \item{token}{If you have ran the 'qualtricsAuth' function, then you can simply use 'token' here. Otherwise, you will need to use your regular Qualtrics token (e.g., "tokenString").
}
  \item{format}{This should be "XML".
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

surveyNamesID("qualtricsUser@email.address#brand", "tokenString", "XML")
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ Qualtrics }
