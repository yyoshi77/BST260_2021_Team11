
url <- links[1]
age <- read_html(url) %>% 
  html_nodes("table") %>% 
  .[[1]] %>% 
  html_table() %>% 
  .[.[,1]=="Born",] %>% 
  .[,2] %>% as.character()
#

age0 <- NULL
for(i in 1:length(links)){
  age0[i] <- read_html(links[i]) %>% 
    html_nodes("table") %>% 
    .[[1]] %>% 
    html_table() %>% 
    .[.[,1]=="Born",] %>% 
    .[,2] %>% as.character()
}
age0

age_fun <- function(link){
  read_html(link) %>% 
    html_nodes("table") %>% 
    .[[1]] %>% 
    html_table() %>% 
    .[.[,1]=="Born",] %>% 
    .[,2] %>% as.character()
}

a <- sapply(links[24], age_fun)


age <- read_html(links[24]) %>% 
  html_nodes("table") %>% 
  .[[1]] %>% 
  html_table() %>% 
  .[.[,1]=="Born",] %>% 
  .[,2] %>% as.character()

a <- read_html(links[23]) %>% 
  html_nodes(".infobox-data") %>% 
  .[[2]] %>% 
  html_text()