1. [BASH](#bash)
1. [ImageMagick](#imagemagick)
1. [Postgres](#postgres)
1. [R](#r)


# Bash <a name='bash'></a>

## Commands

`proj` go to projects directory

`shproj` go to short projects directory

`scratch` go to scratch directory

`twosets` launch twosets application

`quicktab` launch quicktab application

`mquicktab` launch mquicktab application

`vcreate` create new virtual environment

`vact` activate directory's virtual environment

`vdeact` deactivate directory's virtual environment

`dams|mis|indx|ddfprod` launch tunnel to relevant environment

`toqueryscp <src> <dest>` scp src to dest on query 

`fromqueryscp <src> <dest>` scp src to dest from query 

`mktmp <ext>` make a temporary file in scratch with file extension (default txt)

`google|stackoverflow <search>` do google or stackoverflow search for something

## Snippets

### Convert xlsx to psv

```bash
find . -type f -name "*.xlsx" | while read file; do ssconvert -O 'separator=|' "$file" "${file%.xlsx}.txt"; done
```

### scp with rename

scp files and rename according to psv file with info, in this case for-download is `<participant_id>|<file_num>|<source_filename>`

```bash
cat for-download.txt | while IFS='|' read part id inf; do
    out="${part}_${id}.png"
    scp sthompson@10.1.24.38:"$inf" ~/Downloads/cf/$out
done
```

### Count number of files by file extension

```bash
find . -type f | sed -e 's/.*\.//' | sed -e 's/.*\///' | sort | uniq -c | sort -rn > file-extension-totals.txt
```

### Flatten tree of pngs to pdfs

Takes a folder tree of pngs and converts them to pdf per folder. e.g.
```
|- 1 
|  |- 1_1.png
|  |- 1-2.png
|- 2
|  |- 2_1.png
|  |- 2_2.png
```

 will create two pdfs called 1.pdf and 2.pdf in the directory of script.

```bash
for file in `find . -name "*.png" -exec dirname {} \; | sort | uniq`
do
	base="$(basename $file)"
	echo "$base"
	files="$(find $file -type f -name "*.png" | sort)"
	echo "$files"
	convert $files "$base.pdf"
done
```

# ImageMagick <a name='imagemagick'></a>

## Snippets

### Convert pdf to numbered pngs

Converts folder of pdfs to set of pngs with `_p01` suffixes

```bash
for file in *.pdf; do
    echo 'converting $file'
    convert -density 400 -colorspace sRGB $file -scene 1 -alpha off ${file%.pdf}_p%02d.png;
done
```

# Postgres <a name='postgres'></a>

## Commands

`<some date> > now() - interval '9 month'` get only rows from last 9 months

`date(date_trunc('week', <some date))` round down to week of some_date
 
`string_agg(<col>, ';')` equivalent to R's paste(<field>, collapse = ";")

## Snippets

### Row number over partition

```sql
select participant_id
    ,row_number() over(partition by participant_id) as row_index
from blahdiblah
```
 
### Select random rows
 
```sql
-- select a random percentage of rows of table
select * from my_table tablesample bernoulli(<percentage in numbers, e.g. 10>)
-- or to select random rows in query
select * from query order by random() limit 100
```

### Transfer schema from index to local

```bash
# on query
pg_dump -h 10.1.24.39 -p 5433 --schema <schema-name> <db_name> > ~/scratch/<dump_file>.sql
 
# local
scratch
scp sthompson@10.1.24.38:~/scratch/<dump_file>.sql .
sed -i .bak 's/OWNER TO dw_user;/OWNER TO simon;/g' <dump_file>.sql
psql -d <target_db> -h localhost -p 5432 -U simon < <dump_file>.sql
```

### Copy table from one schema to another

```sql
create table schema2.the_table (like schema1.the_table including all);
alter table schema2.the_table owner to dw_user;
insert into schema2.the_table
select *
from schema1.the_table;
```

# R <a name='r'></a>

## Commands

`sprintf("%02d", <num>)` get constant width number as string (9 > 09), increase %02d to get more width
 
`format(now(), "%Y%m%d-%H%M%S")` get timestamp
 
### dplyr 

#### Commands

|Command|Purpose|
|-------|-------|
|`select()`|Select columns from a data frame|
|`filter()`|Filter rows according to some condition(s)|
|`arrange()`|Sort / Re-order rows in a data frame|
|`mutate()`|Create new columns or transform existing ones|
|`transmute()`|Like mutate() but only the create columns are kept|
|`group_by()`|Group a data frame by some factor(s) usually in conjunction to summary|
|`summarize()`|Summarize some values from the data frame or across groups|
|`inner_join(x,y,by=”col”)`|return all rows from ‘x’ where there are matching values in ‘x’, and all columns from ‘x’ and ‘y’. If there are multiple matches between ‘x’ and ‘y’, all combination of the matches are returned.|
|`left_join(x,y,by=”col”)`|return all rows from ‘x’, and all columns from ‘x’ and ‘y’. Rows in ‘x’ with no match in ‘y’ will have ‘NA’ values in the new columns. If there are multiple matches between ‘x’ and ‘y’, all combinations of the matches are returned.|
|`right_join(x,y,by=”col”)`|return all rows from ‘y’, and all columns from ‘x’ and y. Rows in ‘y’ with no match in ‘x’ will have ‘NA’ values in the new columns. If there are multiple matches between ‘x’ and ‘y’, all combinations of the matches are returned|
|`anti_join(x,y,by=”col”)`|return all rows from ‘x’ where there are not matching values in ‘y’, keeping just columns from ‘x’|
|`sample_n()`|sample a random number of rows|
|`sample_frac()`|sample a random proportion of rows|

#### `select()` Arguments

| Argument | Purpose |
|----------|---------|
|`starts_with(x, ignore.case = TRUE)`|Finds columns whose name starts with “x”|
|`ends_with(x, ignore.case=TRUE)`|Finds columns whose name ends with “x”|
|`contains(x, ignore.case=TRUE)`|Finds columns whose name contains “x”|
|`matches(x, ignore.case=TRUE)`|Finds columns whose names match the regular expression “x”|
|`num_range(“x”,1:5, width=2)`|selects all variables (numerically) from x01 to x05|
|`one_of(“x”, “y”, “z”)`|Selects variables provided in a character vector|
 

## Snippets and Functions

### Round nicely

Round a number to a pleasant-looking number

```r
roundNicely <- function(x, nice=c(1,1.5,2,2.5,3,4,5,6,8,10), down = TRUE) {
    stopifnot(length(x) == 1)
    if(down){
        10^floor(log10(x)) * nice[which(x <= 10^floor(log10(x)) * nice)[1] - 1]
    } else {
        10^floor(log10(x)) * nice[which(x <= 10^floor(log10(x)) * nice)[1]]
    }
}
```

e.g.:

```r
> roundNicely(0.000212)
[1] 0.0002
> roundNicely(3890127891, down = FALSE)
[1] 4000000000
```

### Export dataframe by factor

Write out to a zip file a set of dataframes per category

```r
writeTablesPerCat <- function(df, cat, fn, zip_flags = "-j", na_string = "", replace = TRUE){
	stopifnot(cat %in% colnames(df))
	df_ls <- split(df, df[[cat]])
	names(df_ls) <- tolower(gsub(" ", "-", names(df_ls)))
	files <- sapply(names(df_ls), function(x) paste0(tempdir(), "/", basename(fn), "-", x, ".txt"))
	for(i in names(df_ls)){
		write_tsv(df_ls[[i]][,!colnames(df_ls[[i]]) %in% cat], files[i], na = na_string)
	}
	if(replace == TRUE){
		suppressWarnings(file.remove(paste0(fn, ".zip")))
	}
	zip(paste0(fn, ".zip"), files, flags = zip_flags)
	file.remove(files)
}
```

### Export date-stamped csv

```r
writeCSV <- function(df, fn){
    ffn <- paste0(fn, "-", Sys.Date(), ".csv")
    write.csv(df, ffn, row.names = F)
}
```

### Export to formatted xlsx

```r
writeXlsx <- function(d, fn, sheet_name = ''){
	require(openxlsx)
	# creates xlsx workbook containing data
	# header styling
	hs1 <- createStyle(fgFill = "#4F81BD", halign = "LEFT", textDecoration = "Bold", border = "Bottom", fontColour = "white")
	cs1 <- createStyle(wrapText = TRUE, halign = 'LEFT', valign = 'top')
	wb <- createWorkbook() 
	addWorksheet(wb, sheetName=sheet_name)
	setColWidths(wb, 1, 1:ncol(d), 'auto')
	freezePane(wb, 1, firstRow = TRUE)
	writeData(wb, 1, d, headerStyle = hs1)
	addStyle(wb, 1, style = cs1, rows = 2:(nrow(d) + 1), cols = 1:ncol(d), gridExpand = TRUE)
	saveWorkbook(wb, fn, overwrite = TRUE)
}
```

### Hash data

Hash each line of a dataframe

```r
require(digest)
df$hash <- apply(df, 1, digest)
```

### dplyr

```r
#-- convert df to tibble
tbl <- tbl_df(df)
 
#-- aggregate by multiple groups
d <- df %>% filter(<filter_conditional>) %>%
    group_by(<grouping_variable1>, ...) %>%
    summarise(<out_var> = <out_var_function_call>,...)
 
#-- get crosstabs table and replace low counts
tab_ldp <- d %>%
    rename(dis = normalised_disease_name) %>%
    group_by(gmc, ldp, dis) %>%
    summarise(n = n()) %>%
    spread(dis, n) %>%
    mutate_if(is.numeric, function(x) replace(x, x %in% 1:5, "<5"))
 
#-- select only columns that start with m
d <- df %>% select(starts_with("m"))
 
#-- mutate weight to be in kgs and create new var
mtcars <- mtcars %>% mutate(wt = wt * 1000, good_mpg=ifelse(mpg > 25,"good","bad"))
 
#-- equivalent of do.call("rbind", list(dfs))
bind_rows(df1, df2)
bind_rows(list(df1, df2))
bind_rows(list_of_dfs, .id = "id") # .id argument allows to specify a new column name to preserve the original list names
 
#-- get the first or last or nth row of the group
d <- df %>%
    group_by(grp_var) %>%
    arrange(desc(order_var)) %>%
    slice(1) # or could use n() to get the number of rows in that group
 
#-- long list to crosstab/pivot
out <- d %>% group_by(week, lab) %>% summarize(count = n()) %>% spread(lab, count)
 
#-- change class of number of specific columns (specified in a vecotr of column names
d <- d %>% mutate_at(vars(one_of(convert_to_numeric)), funs(as.numeric))
```
