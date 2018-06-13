# Packages 
library(rvest)
library(tidyverse)

# Preparation
page_link <- "http://whiskyadvocate.com/ratings-reviews/?search=&submit=+&brand_id=0&rating=0&price=0&category=1%2C3%2C4%2C6%2C51&styles_id=0&issue_id=0"
page.html <- read_html(page_link)

# Scraping
all.items <- page.html %>% 
  html_nodes("div.m-all")

# Rating Value
review.point <- all.items[1:2247] %>% 
  html_nodes("article") %>% 
  html_nodes("div.review-top") %>% 
  html_nodes("h2") %>% 
  html_nodes("span") %>% 
  html_text()

# Name
name <- all.items[1:2247] %>% 
  html_nodes("article") %>% 
  html_nodes("div.printable-section") %>% 
  html_nodes("h1") %>% 
  html_text()

# Category
category <- all.items[1:2247] %>% 
  html_nodes("article") %>% 
  html_nodes("div.printable-section") %>% 
  html_nodes("p.entry-meta") %>% 
  html_nodes("[itemprop = aggregateRating]") %>% 
  html_nodes("[itemprop = category]") %>% 
  html_text()

# Price
price <- all.items[1:2247] %>% 
  html_nodes("article") %>% 
  html_nodes("div.printable-section") %>% 
  html_nodes("p.entry-meta") %>% 
  html_nodes("[itemprop = aggregateRating]") %>% 
  html_nodes("[itemprop = price]") %>% 
  html_text()
  
# Price Currency
currency <- all.items[1:2247] %>% 
  html_nodes("article") %>% 
  html_nodes("div.printable-section") %>% 
  html_nodes("p.entry-meta") %>% 
  html_nodes("[itemprop = aggregateRating]") %>% 
  html_nodes("[itemprop = priceCurrency]") %>% 
  html_text()

# Description
description <- all.items[1:2247] %>% 
  html_nodes("article") %>% 
  html_nodes("div.printable-section") %>% 
  html_nodes("[itemprop= description]") %>% 
  html_nodes("p") %>% 
  html_text()

# Create Dataframe
df <- data.frame(name, category, review.point, price,
                 currency, description[1:2247])

# Finish
write.csv(df, file = "scotch_review.csv")










