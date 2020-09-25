
# The following prevents build-machines (Jenkins) from locking (freezing) and a crash at the end of a build.
# https://stackoverflow.com/questions/7916687/error-msb4166-child-node-exited-prematurely-shutting-down
# https://techdocs.ed-fi.org/display/ODSAPI20/Step+4.+Prepare+the+Development+Environment
# We can use "-nodeReuse:False" with "-maxCpuCount" on a MSBuild call but it is possible to use "$env:MSBUILDDISABLENODEREUSE = 1" globally to do the same.
$env:MSBUILDDISABLENODEREUSE = 1