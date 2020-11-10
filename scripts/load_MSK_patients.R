#Oct/05/2020
#
#This scripts load MSK patient data (clinical and antibiotic side),
#It organizes it in antibiotics and clinical side. 
#
#

library(data.table);


if(!(exists("dt_CART_MSK_antibiotic") & exists("dt_CART_MSK_clinical"))){

  
  # dt_carT_sampleid_info = openxlsx::read.xlsx("/Volumes/castoricenter/CAR-Tcell_and_Microbiota/CTC Event Table01132020.xlsx",#CTC Event Table 11252019 wo Censor .xlsx",
  #                                             sheet = "Sample IDs only ");
  
  #dt_CART_MSK_clinical = openxlsx::read.xlsx("/Volumes/Attending queries/Smith. M/CAR Intestinal Microbiome (Jain; 16-834)/CAR Microbiome_2020Jan25v2.xlsx",sheet=1);
  dt_CART_MSK_clinical = openxlsx::read.xlsx("/Volumes/Attending queries/Smith. M/CAR Intestinal Microbiome (Jain; 16-834)/CAR Microbiome_2020Oct22.xlsx",sheet=1);
  dt_CART_MSK_clinical = data.table(dt_CART_MSK_clinical)
  dt_CART_MSK_clinical$CR = ifelse(dt_CART_MSK_clinical$Day.30.Response=="CR",1,0)#"Y","N");
  dt_CART_MSK_clinical$CR_d100 = ifelse(dt_CART_MSK_clinical$Day.100.Response=="CR",1,0)#"Y","N");
  dt_CART_MSK_clinical$Tox_Neuro_and_CRS = ifelse(dt_CART_MSK_clinical$Neuro.tox=="Y" | dt_CART_MSK_clinical$Any.Grade.CRS=="Y",1,0)#"Y","N");
  dt_CART_MSK_clinical$Tox_CRS = ifelse(dt_CART_MSK_clinical$Any.Grade.CRS=="Y" | dt_CART_MSK_clinical$Any.Grade.CRS=="Y",1,0)#"Y","N");
  
  
  dt_CART_MSK_clinical[, infusion_date:= as.Date((IEC.Date),format = "%Y-%m-%d",origin="1899-12-30")]
  

  dt_CART_MSK_antibiotics = fread("/Volumes/CastoriCenter/CAR-Tcell_and_Microbiota/data/CarT_patients_extended/abx summary.csv");
  #dt_CART_MSK_antibiotics = data.table(dt_CART_MSK_antibiotics);
  dt_CART_MSK_antibiotics[,CarInfusionDate := .(as.Date(CarInfusionDate))]
  dt_CART_MSK_antibiotics[,start_date := .(as.Date(start_date))];
  dt_CART_MSK_antibiotics[,stop_date := .(as.Date(stop_date))];
  
  
#  setnames(dt_CART_MSK_antibiotics,"start_date","date_start")
#  setnames(dt_CART_MSK_antibiotics,"stop_date","date_end")
  
  dt_CART_MSK_antibiotics[, drug_name := gsub("-","_",order_name)]
  
  drug_name_clean_map = c("amoxicillin_clavulanate" = "amoxicillin",
                          "ampicillin_sulbactam" = "ampicillin",
                          "IV vancomycin" = "vancomycin.iv",
                          "PO vancomycin" = "vancomycin.oral",
                          "polymyxin b" = "polymixin b");

  for(i in 1:length(drug_name_clean_map)){
    drug_name_cur = names(drug_name_clean_map)[i];
    drug_name_clean_cur = drug_name_clean_map[i];
    
    dt_CART_MSK_antibiotics[drug_name %in% drug_name_cur, drug_name := drug_name_clean_cur];
  }
  
  dt_CART_MSK_antibiotics[,pid := MRN];
  dt_CART_MSK_clinical[, pid := MRN];
  
}

print("dt_CART_MSK_clinical and dt_CART_MSK_antibiotics are loaded!")
