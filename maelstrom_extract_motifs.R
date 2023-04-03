library(tidyverse)

args <- commandArgs(trailingOnly = TRUE)

data_df_nr <- read_tsv(args[1],) %>% 
  pivot_longer(cols = !loc) %>% 
  filter(value == 1) %>% 
  separate(col = loc, into = c("chr", "coord"), sep = "\\:", remove = F) %>% 
  separate(col = coord, into = c("start", "end"), sep = "-") %>% 
  separate(col = name, into = c("A", "B"), sep = "_",remove = F) %>%
  separate(col = B, into = c("a", "b", "TF"), sep = "\\.") %>% 
  select(chr:end, TF)


list_dfs_nr <- data_df_nr %>% 
  nest(.by=TF)

#list_dfs_nr$TF[4]
#list_dfs_nr[[2]][[4]]

#nrow(list_dfs_nr)
#ncol(list_dfs_nr)

# create a function
split_list_dfs <- function(users_list) {
  dir_name = "motifs_nr_coord"
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
    print(paste0("now writing motif ", x , ": ", motif, " > ", file))
    write_tsv(users_list[[ncol_dfs]][[x]], 
              file.path(dir_name, file), col_names = F)
  }
}

# run the function
split_list_dfs(list_dfs_nr)  
