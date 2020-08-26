.setUp <- function() {}
.tearDown <- function() {}

test.number <- function()
{
	json <- "0"
	x <- fromJSON( json )
	checkIdentical( x, 0 )

	json <- "-0"
	x <- fromJSON( json )
	checkIdentical( x, 0 )

	json <- "15.05"
	x <- fromJSON( json )
	checkIdentical( x, 15.05 )

	json <- "-10.3"
	x <- fromJSON( json )
	checkIdentical( x, -10.3 )

	json <- "-0.3"
	x <- fromJSON( json )
	checkIdentical( x, -0.3 )

	json <- "0.3e3"
	x <- fromJSON( json )
	checkIdentical( x, 300 )

	json <- "0.2e+4"
	x <- fromJSON( json )
	checkIdentical( x, 2000 )

	json <- "0.1e-4"
	x <- fromJSON( json )
	checkIdentical( x, 0.00001 )

	# TODO check for invalid entries like 0.1e-4.5?
	failing_json <- c( ".3", "-.3", "0.1e" )
	for( bad_json in failing_json ) {
		x <- try( fromJSON( bad_json ), silent = TRUE )
		checkTrue( any( class( x ) == "try-error" ) )
	}
}


