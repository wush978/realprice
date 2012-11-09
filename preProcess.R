load("realprice.Rdata")
# gc()
# sapply(realprice, names)[,1]
# sapply(realprice, function(a) names(a$fields))
# x <- realprice[[1]]
check.null <- function(a) {
	ifelse(is.null(a), NA, a)
}
source("search.list.R")

n <- length(realprice)
retval <- NULL
for(i in 1:n) {
	x <- realprice[[i]]
	y <- data.frame(
		unit = check.null(x$fields[["交易單價 約"]]),
		latitude = check.null(as.numeric(x$pos[2])),
		longitude = check.null(as.numeric(x$pos[1])),
		address = check.null(x$address),
		deal_year = check.null(x$fields[["交易年月"]]$year),
		deal_month = check.null(x$fields[["交易年月"]]$month),
		schema = check.null(x$fields[["建物現況格局"]]),
		is_manager = check.null(x$fields[["有無管理組織"]]),
		building_type = check.null(x$fields[["建物型態"]]),
		seq = check.null(x$caseSeq),
		no = check.null(x$caseNo)
		)
	temp <- search.list(x, "完成年月")
	if (is.null(temp)) {
		y$building_year <- NA
		y$building_month <- NA
	} else {
		y$building_year <- temp$year
		y$building_month <- temp$month
	}
	temp <- search.list(x, "主要建材")
	if (is.null(temp)) {
		y$material <- NA
	} else {
		y$material <- temp
	}
	
	if(is.null(retval)) {
		retval <- y
	} else {
		retval <- rbind(retval, y)
	}
}
realprice <- retval
save(realprice, file="realprice.dataframe.Rdata")