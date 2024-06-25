# Script 1
maVariable1 <- list(1, 2, 9)
maVariable2 <- list(10, 20, 90)
getwd()
write.csv(maVariable1, "/home/onyxia/work/first_project/maVariable1.csv")
write.csv(maVariable2, "/home/onyxia/work/first_project/maVariable2.csv")
raw=c(1, 2, 4, 4, 4, 4, 78, 987, 9, 0, 0, 1)
write.csv(raw, "/home/onyxia/work/first_project/data/raw.csv", row.names = FALSE)

install.packages("filesstrings")
library(filesstrings)
getwd()
file.move("/home/onyxia/work/first_project/script/script.R", "/home/onyxia/work/first_project/scripts")
file.move("/home/onyxia/work/first_project/get_data.R", "/home/onyxia/work/first_project/scripts")

# Essai lintr
library(lintr)
lintr::lint_dir()
