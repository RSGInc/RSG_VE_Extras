% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/Initialize.R
\name{Initialize}
\alias{Initialize}
\title{Check and adjust fuel and powertrain proportions inputs.}
\usage{
Initialize(L)
}
\arguments{
\item{L}{A list containing data from preprocessing supplied optional input
files returned by the processModuleInputs function. This list has two
components: Errors and Data.}
}
\value{
A list that is the same as the input list with an additional
Warnings component.
}
\description{
\code{Initialize} checks the required worker proportion by azone, location type,
and occupation mix
to determine whether they each sum to 1, creates error and warning messages,
and makes adjustments if necessary. It also verifies the consistencey of the values
compared to the values in household proportion by location type and azone.
}
\details{
This function processes the required  worker proportion by azone, location type,
and occupation mix inputs that have
been preprocessed by the processModuleInputs function. It checks the 
proportions to determine whether
they sum to 1. If the sum for a dataset differs from 1 by more than 1%, then
the function returns an error message identifying the problem dataset. If the
sum differs from 1 but the difference is 1% or less it is assumed that the
difference is due to rounding errors and function adjusts the proportions so
that they equal 1. In this case, a warning message is returned as well that
the framework will write to the log. It also verifies the consistencey of the values
compared to the values in household proportion by location type and azone.
If there are inconsistency then an error message is thrown showing the year
azone and the location type where the error was noted.
}
