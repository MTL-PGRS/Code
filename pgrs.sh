head scz2.snp.results.txt
cat scz2.snp.results.txt | awk 'BEGIN { OFS="\t"} {if (NR==1) {print "SNP","CHR","BP", "A1","A2","OR","P"}}' > PGC-SCZ2.BASE.assoc #Exclude BP as simulated target data
cat scz2.snp.results.txt | sed s/chr//g | awk 'BEGIN { OFS="\t"} {if (NR>1) {print $2, $1, $5, $3, $4, $7, $9}}' >> PGC-SCZ2.BASE.assoc
head PGC-SCZ2.BASE.assoc
head simaut.fam

#Generate target phenotype data
#Make a unique personal identifier (PIS, second column) of the gwas file, as needed by PRSice
cat simaut.fam | awk 'BEGIN { OFS="\t"} {print $1, $2, $1, $1 }'  > recoded.txt
plink --bfile simaut --update-ids recoded.txt --make-bed --out simaut.id
Imore simaut.id.fam
cat simphen.phen | cut -d' ' -f1,3 > SIMAUT_QUANTITATIVE.pheno
head SIMAUT_QUANTITATIVE.pheno

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#Run PRSice without clumping of SNPs
#Tutor demonstration
#DO NOT RUN
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#R -q --file=/opt/cluster/external/prsice/PRSice_v1.25.R --args \
#base PGC-SCZ2.BASE.assoc \
#target simaut.id \
#slower 0 \
#supper 0.5 \
#sinc 0.01 \
#covary F \
#clump.snps F \
#plink /opt/cluster/external/prsice/plink_1.9_linux_160914 \
#figname simout.all \
#pheno.file SIMAUT_QUANTITATIVE.pheno \
#binary.target F

gwenview simout.all_BARPLOT_2016-06-28.png
gwenview simout.all_HIGH-RES_PLOT_2016-06-28.png

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#Run PRSice with clumping of SNPs (default settings for SNP removal: 250 kb window, r2 > 0.1 )
#Tutor demonstration
#DO NOT RUN
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#R -q --file=/opt/cluster/external/prsice/PRSice_v1.25.R --args \
#base PGC-SCZ2.BASE.assoc \
#target simaut.id \
#slower 0 \
#supper 0.5 \
#sinc 0.01 \
#covary F \
#clump.snps T \
#plink /opt/cluster/external/prsice/plink_1.9_linux_160914 \
#figname simaut.clump \
#pheno.file SIMAUT_QUANTITATIVE.pheno \
#binary.target F

gwenview simaut.clump_BARPLOT_2016-06-28.png
gwenview simaut.clump_HIGH-RES_PLOT_2016-06-28.png
