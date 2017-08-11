# Script for updating R
# Inspiration: http://www.datascienceriot.com//r/upgrade-R-packages/ 

# PURPOSE:
# To prevent one from losing record of installed R packages

# BACKGROUND: 
# After a some time using R, people end up having a significant number of R
# packages installed. During R installations, it is not uncommon for the user
# to find that they have to install everything all over. This can be a pain 
# for those that have hundreds, or even thousands of packages installed. 


        ##########  Special Notices!  #############
        ##                                       ##
        ##   1. INTERNET CONNECTION REQUIRED!    ##
        ##                                       ##
        ##   2. Run in RGUI, not in RStudio!!    ##
        ##                                       ##
        ###########################################

# STEP 1: Preliminaries
## Set up working directory
newdir <- "R-installation"
dir.create(newdir)
setwd(newdir)

# STEP 2: Load the 'installr' package
if (!require(installr)) {
        install.packages(installr)
}

# STEP 3: Make a local list of your current packages
tmp <- installed.packages()
installedPkgs <- as.vector(tmp[is.na(tmp[ , "Priority"]), 1])
save(installedPkgs, file = "old-packages.rda")  # for use after installation

# STEP 4: Update your R installation
installr::updateR(copy_packages = TRUE,
                  browse_news = FALSE,
                  install_R = TRUE,
                  copy_Rprofile.site = TRUE,
                  keep_old_packages = TRUE,
                  update_packages = FALSE,
                  start_new_R = TRUE,
                  quit_R = FALSE,
                  GUI = TRUE,
                  keep_install_file = TRUE,
                  silent = FALSE)

# STEP 5: Reinstall your old packages (from this point, run in your
# fresh R installation's workspace). To quickly open this script over
# there, run file.edit("updating.R") in the console.
# NOTE: This may take a while - grap some coffee!
load("old-packages.rda")
tmp <- installed.packages()
newly_installed <- as.vector(tmp[is.na(tmp[ , "Priority"]), 1])
missing <- setdiff(installedPkgs, newly_installed)
message(paste(length(missing), "packages missing!"))
install.packages(missing)

# STEP 6 (OPTIONAL):
## If you have LOTS of R scripts you are advised not to update your packages
## until you have implemented Package Dependency Management with, say,
## 'packrat', which is a topic for another day. If curious, visit
## http://rstudio.github.io/packrat/
switch(menu(c("Yes", "No"),
            title = "Do you want to update your packages?"),
       update.packages(),
       cat("Packages not updated. End of R installation.\n"))

# STEP 7: Clean-up
## Removes the directory created for this installation and clears workapsce
rm(list = ls())
setwd("../")
unlink("R-installation", recursive = TRUE)
