search.list <- function(list.obj, key) {
	if (!is.null(list.obj[[key]])) {
		return(list.obj[[key]])
	}
	retval <- NULL
	for(i in 1:length(list.obj)) {
		if (class(list.obj[[i]]) == "list") {
			temp <- search.list(list.obj[[i]], key)
			if (!is.null(temp)) {
				retval <- temp
			}
		}
	}
	return(retval)
}
