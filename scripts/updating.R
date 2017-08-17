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

# STEP 1: Load the 'installr' package
if (!require(installr)) {
        install.packages(installr)
}

# STEP 2: Make a local list of your current packages
tmp <- installed.packages()
installedPkgs <- as.vector(tmp[is.na(tmp[ , "Priority"]), 1])
save(installedPkgs, file = "old-packages.rda")  # for use after installation

# STEP 3: Update your R installation
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

# STEP 4: Reinstall your old packages:
# Inside the new R session, navigate to same folder and open this script.
# Continue below the dotted line.
#.......................................................................
load("old-packages.rda")
tmp <- installed.packages()
newly_installed <- as.vector(tmp[is.na(tmp[ , "Priority"]), 1])
missing <- setdiff(installedPkgs, newly_installed)

qty <- length(missing)
if (qty != 0) {
	message(paste(qty, "packages missing!"))
	install.packages(missing)
} else { message("No packages missing.") }

# STEP 5 (OPTIONAL):
## If you have LOTS of R packages you are advised not to update them
## until you have implemented Package Dependency Management with, say,
## 'packrat', which is a topic for another day. For more info, visit
## http://rstudio.github.io/packrat/
switch(menu(c("Yes", "No"),
            title = "Do you want to update your packages?"),
       update.packages(),
       cat("Packages not updated. End of R installation.\n"))

# STEP 6: Clean-up
rm(list = ls())
file.remove("old-packages.rda")
