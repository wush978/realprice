load("realprice.Rdata")
# gc()
# sapply(realprice, names)[,1]
# sapply(realprice, function(a) names(a$fields))
# x <- realprice[[1]]
n <- length(realprice)
retval <- NULL
for(i in 1:n) {
	x <- realprice[[i]]
	y <- data.frame(
		unit = x$fields[["交易單價 約"]],
		latitude = as.numeric(x$pos[2]),
		longitude = as.numeric(x$pos[1]),
		address = x$address,
		deal_year = x$fields[["交易年月"]]$year,
		deal_month = x$fields[["交易年月"]]$month,
		schema = x$fields[["建物現況格局"]],
		is_manager = x$fields[["有無管理組織"]],
		building_type = x$fields[["建物型態"]],
		material = x$details[[3]][["主要建材"]],
		seq = x$caseSeq,
		no = x$caseNo
		)
	if(is.null(retval)) {
		retval <- y
	} else {
		retval <- rbind(retval, y)
	}
}
realprice <- retval
save(realprice, file="realprice.dataframe.Rdata")