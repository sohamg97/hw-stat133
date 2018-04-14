hw04-soham-ghosh
================

HW 04
=====

### 1.4) Archive of "stringr"

``` r
library(ggplot2)
source("../code/archive-functions.R")
raw_data <- read_archive('stringr')
clean_data <- clean_archive(raw_data)
plot_archive(clean_data)
```

![](../images/unnamed-chunk-1-1.png)

### 1.5) Archives of "splyr", "ggplot2", "XML", and "knitr"

``` r
r_ggplot <- read_archive('ggplot2')
c_ggplot <- clean_archive(r_ggplot)
write.csv(c_ggplot, "../data/ggplot2-archive.csv")
r_xml <- read_archive('XML')
c_xml <- clean_archive(r_xml)
write.csv(c_xml, "../data/xml-archive.csv")
r_knitr <- read_archive('knitr')
c_knitr <- clean_archive(r_knitr)
write.csv(c_knitr, "../data/knitr-archive.csv")
r_dplyr <- read_archive('dplyr')
c_dplyr <- clean_archive(r_dplyr)
write.csv(c_dplyr, "../data/dplyr-archive.csv")
r_stringr <- read_archive('stringr')
c_stringr <- clean_archive(r_stringr)
write.csv(c_stringr, "../data/stringr-archive.csv")

big_plot <- rbind(c_dplyr, c_ggplot, c_knitr, c_xml)
ggplot(big_plot, aes(x = date, y = size, color = name)) +
  labs(y = 'Size (kilobytes)', x = 'Date') +
  geom_step()
```

![](../images/unnamed-chunk-2-1.png)

``` r
ggplot(big_plot, aes(x = date, y = size, color = name)) +
  geom_step() + 
  labs(y = 'Size (kilobytes)', x = 'Date') + 
  facet_wrap(~ name, scales = 'free')
```

![](../images/unnamed-chunk-2-2.png)

2) Regex Functions
------------------

``` r
source("../code/regex-functions.R")
split_chars('Go Bears!')
```

    ## [1] "G" "o" " " "B" "e" "a" "r" "s" "!"

``` r
split_chars('Expecto Patronum')
```

    ##  [1] "E" "x" "p" "e" "c" "t" "o" " " "P" "a" "t" "r" "o" "n" "u" "m"

``` r
num_vowels(vec)
```

    ## a e i o u 
    ## 1 1 0 1 0

``` r
count_vowels("The quick brown fox jumps over the lazy dog")
```

    ## a e i o u 
    ## 1 3 1 4 2

``` r
count_vowels("THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG")
```

    ## a e i o u 
    ## 1 3 1 4 2

``` r
reverse_chars("gattaca")
```

    ## [1] "acattag"

``` r
reverse_chars("Lumox Maxima")
```

    ## [1] "amixaM xomuL"

``` r
reverse_words("sentence! this reverse")
```

    ## [1] "reverse this sentence!"

``` r
reverse_words("string")
```

    ## [1] "string"

Data "Emotion" in Text
----------------------

``` r
content = read.csv("../data/text-emotion.csv", stringsAsFactors = FALSE)$content
```

### 3.1) Number of characters per tweet

``` r
number = nchar(content)
print(summary(number))
```

    ##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    ##    1.00   43.00   69.00   73.41  103.00  167.00

``` r
hist(number, breaks = seq(0, max(number) + 5, by = 5))
```

![](../images/unnamed-chunk-5-1.png)

### 3.2) Number of Mentions

``` r
mentions = 1:length(content)
for (i in mentions) {
  mentions[i] = sum(grepl("^[^@@]*@[A-Za-z0-9_]{1,15}$", str_split(content[i], " ")[[1]]))
}
mentions = unlist(mentions)
mention_count = table(mentions)
barplot(mention_count)
```

![](../images/unnamed-chunk-6-1.png)

``` r
mention_count
```

    ## mentions
    ##     0     1     2     3     4     5     6     7     8     9    10 
    ## 21375 17933   569    75    28    13     2     1     2     1     1

``` r
content[mentions == 10]
```

    ## [1] "last #ff  @Mel_Diesel @vja4041 @DemonFactory @shawnmcguirt @SEO_Web_Design @ChuckSwanson @agracing @confidentgolf @tluckow @legalblonde31"

### 3.3) Hashtags

``` r
hashtags = 1:length(content)
hashtag_length = rep(0,max(number))

for (i in hashtags) {
  tweets = str_split(content[i], " ")[[1]]
  tags = grep("^#[A-Za-z][A-Za-z0-9]*", tweets, val = T)
  size = nchar(tags) - 1
  hashtag_length[size] = hashtag_length[size] + 1
  hashtags[i] = length(tags)
}

names(hashtag_length) <- 1:length(hashtag_length)
hashtag_length <- hashtag_length[hashtag_length > 0]
hashtags = unlist(hashtags)
hashtag_counts = table(hashtags)

hashtag_counts
```

    ## hashtags
    ##     0     1     2     3     5     7     8     9 
    ## 39265   647    65    17     1     1     1     3

``` r
barplot(hashtag_counts)
```

![](../images/unnamed-chunk-7-1.png)

``` r
sum(hashtag_length*as.numeric(names(hashtag_length))/sum(hashtag_length))
```

    ## [1] 7.887668

``` r
names(hashtag_length[hashtag_length == max(hashtag_length)])
```

    ## [1] "4"

Average length of hashtags: 7.887668 Most common length of hashtags: 4
