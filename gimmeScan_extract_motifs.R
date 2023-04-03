library(tidyverse)

args <- commandArgs(trailingOnly = TRUE)

data_df <- read_tsv(args[1],
                    comment = "#", col_names = F) %>%
  separate(col = X4, into = c("A", "B"), sep = "_",remove = F) %>%
  separate(col = B, into = c("a", "b", "TF"), sep = "\\.") %>% 
  select(X1:X3, TF)


list_dfs <- data_df %>% 
  nest(.by=TF)

#list_dfs$TF[1]
#list_dfs[[2]][[1]]

#nrow(list_dfs)
#ncol(list_dfs)

# create a function
split_list_dfs <- function(users_list) {
  #dir_name = args[2]
  #dir.create(dir_name)
  
  #extract directory name
  dir_name = args[1]
  dir_name = paste0("gimme_scan_",str_split_i(dir_name, "_", 1))
  dir.create(dir_name)
  nrow_dfs = nrow(users_list)
  ncol_dfs = ncol(users_list)
  for (x in 1:nrow_dfs) {
    #print(x)
    df_name = users_list$TF[x]
    #print(name_of_df)
    file = paste0(df_name,".bed")
    #print(file)
    motif = users_list$TF[x]
    #print(paste0("now writing motif ", x , ": ", motif, " > ", file))
    write_tsv(users_list[[ncol_dfs]][[x]],
              file.path(dir_name, file), col_names = F)
  }
}

# run the function
split_list_dfs(list_dfs)  

