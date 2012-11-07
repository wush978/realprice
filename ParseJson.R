library(rjson)
realprice <- fromJSON(file="realprice20121106.json")
save(realprice, file="realprice.Rdata")