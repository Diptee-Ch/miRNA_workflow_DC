
options(java.parameters = "-Xmx80000m")
library(DESeq2)
library(xlsx)


# Extract a Sub-matrix of counts for each group 
subgem <- function(gem, anot, group ){
  
  datalist = list()
  subanot = subset(anot, Comparison == group)
  for (id in subanot$Sample) {
    ind = which(colnames(gem) == id)
    genes = gem[0]
    exp = gem[,ind]
    datalist[[id]] <- exp
  }
  subcounts = cbind(genes, datalist)
  return(subcounts)
}


#Extract a subset of the sample annotation matrix for each group
subanot <- function(anot, group){
  
  datalist = list()
  print(str(group))
  subanot = subset(anot, Comparison == group)
  print(str(subanot))
  return(subanot)
}


# Run DESeq2 
run_deseq <- function(counts, annotation){
  dds <- DESeqDataSetFromMatrix(countData = counts, 
                                colData = annotation,
                                design = ~ Group)
  
  
  # filter genes with low total counts across all samples
  dds <- dds[rowSums(counts(dds)) >= 50,]
  
  dds <- DESeq(dds)
  
  # calculate FPM (fragments per million)
  norm = fpm(dds)
  
  
  #Sort the columns in the FPM DF.  First three samples control, next three inoculated
  
  conditionA = which(annotation[2] == "GroupA")
  conditionB = which(annotation[2] == "GroupB")
  
  norm = subset(norm, select=c(conditionA, conditionB))
  print(str(norm))
  
  
  # Retrieve results
  res <- results(dds, contrast=c("Group", "GroupA", "GroupB"))
  
  print(summary(res))
  
  # Add FPM values to results for easy visualization
  res <- cbind(res, norm)
  
  resultsNames(dds)
  
  return(res)
}


main <- function(countfile, anotfile){
  outname = "Output.xls"
  counts = read.delim(countfile, sep=',', header=TRUE, row.names='gene_id')
  samples = read.delim(anotfile, sep='\t', row.names = NULL, check.names=FALSE)
  
  groups = unique(samples$Comparison)
  
  for (t in groups){
    subcounts = subgem(counts, samples, t)
    subannotation = subanot(samples, t)
    results = run_deseq(subcounts, subannotation)
    
    #Filter and sort results table
    
    o_results = results[order(results$padj),]
    
    
    # Write results of each group to an excel sheet in the workbook
    write.xlsx(o_results, outname, sheetName=t,
               col.names=TRUE, row.names=TRUE, append=TRUE)
  }
  return(results)
}

main('Input.csv', 'Condition.txt')
sessionInfo()

