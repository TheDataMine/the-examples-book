.setUp <- function() {}
.tearDown <- function() {}

test.list <- function()
{
	json <- "{}"
	x <- fromJSON( json )
	checkIdentical( x, list() )

	failing_json <- c( "{", "{a:5}", "{\"a:5}", "{\"a\":", "{\"a\":5", "{\"a\":}", "{123:false}", "{\"a\":unquoted}" )
	for( bad_json in failing_json ) {
		x <- try( fromJSON( bad_json ), silent = TRUE )
		checkTrue( any( class( x ) == "try-error" ) )
	}

	json <- "{\"a\":5}"
	x <- fromJSON( json )
	checkIdentical( x, list( a = 5 ) )

	json <- "{\"a\":5,\"b\":10}"
	x <- fromJSON( json )
	checkIdentical( x, list( a = 5, b = 10 ) )

	json <- "{\"a\":5,\"b\":10, \"clap\":[true,false,false]}"
	x <- fromJSON( json )
	correct <- list( a = 5, b = 10, clap = c(TRUE,FALSE,FALSE) )
	checkIdentical( x, correct )
	checkIdentical( x[["clap"]], correct[["clap"]] )


}

test.nestedlist <- function()
{
	json <- "[\"a\", [\"b\", \"c\"] ]"
	x <- fromJSON( json )
	correct <- list( "a", c( "b", "c" ) )
	checkIdentical( x, correct )
	checkIdentical( x[[2]], correct[[2]] )
}

test.bad.list <- function()
{
	bad_json <- "{\"a\": 123,}"
	x <- try( fromJSON( bad_json ), silent = TRUE )
	checkTrue( any( class( x ) == "try-error" ) )
}

test.unsupported.sexp <- function()
{
	x <- fromJSON('{ "key":[ { "foo":"bar" }, { "bah":"baz" }] }')
	correct <- list( key = list( list( foo = "bar" ), list( bah = "baz" ) ))
	checkIdentical( x, correct )
}

test.rejected.comma <- function()
{
	bad_json = '{ "key":[ { "foo":"bar" }, { "bah":"baz" },] }'
	x <- try( fromJSON( bad_json ), silent = TRUE )
	checkTrue( any( class( x ) == "try-error" ) )
}
