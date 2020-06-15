required_packages <- c('bibliometrix',
                       'tidyverse')

installed_packages <- installed.packages()[, 1]
installed_idx <- required_packages %in% installed_packages
required_packages <- required_packages[!installed_idx]
installed_all_packages <- all(installed_idx)

attempt <- 0
max_attempts <- 5

while(!installed_all_packages) {
    install.packages(pkgs = required_packages, lib = lib_dir);
    installed_packages = installed.packages()[,1]
    installed_idx = required_packages %in% installed_packages;
    installed_all_packages = all(installed_idx);
    required_packages = required_packages[!installed_idx];

    ## Keep track of # of attempts and break loop to prevent hanging
    if (attempt >= max_attempts){
        break;
    } else {
        attempt = attempt + 1;
    }
}

cat(sprintf("Finished in directory: %s\n", getwd()));
