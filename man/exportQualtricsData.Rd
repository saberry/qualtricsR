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
  \item{username}{Your username from Qualtrics.
}
  \item{token}{Your token from Qualtrics.
}
  \item{format}{The format of the data - use "CSV".
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

exportQualtricsData("qualtricsUser@email.address#brand", "tokenString", 
                    "CSV", "idString", dropExtra = TRUE)

}
\keyword{ Qualtrics }