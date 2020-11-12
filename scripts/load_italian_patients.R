#Oct/14/2020
#
#This scripts load Italian data, organizes it in antibiotics and clinical side. 
#
#

if(!(exists("dt_CART_italy_antibiotics") & exists("dt_CART_italy_clinical") & exists("dt_CART_italy_samples_and_outcome"))){


  dt_CART_italy = xlsx::read.xlsx("/Volumes/castoricenter/CAR-Tcell_and_Microbiota/Italy/DATABASE CAR T 091020.xlsx",
                                 sheetIndex = 1);
  dt_CART_italy = data.table(dt_CART_italy);
  setnames(dt_CART_italy,"pt_id.de.identified.","pid");
  dt_CART_italy = dt_CART_italy[!is.na(pid)]
  dt_CART_italy[, CR := ifelse(toupper(CR.Y.N.)=="Y",1,
                               ifelse(toupper(CR.Y.N.)=="N",0,
                               NA))]
  dt_CART_italy[, Tox := ifelse(toupper(Toxicity.Y.N.)=="Y",1,
                               ifelse(toupper(Toxicity.Y.N.)=="N",0,
                                      NA))]
  
  dt_CART_italy_clinical = dt_CART_italy[,infusion_date:=Data.infusione..dd.mm.yy.]
  
  dt_CART_italy_antibiotics = fread("/Volumes/castoricenter/CAR-Tcell_and_Microbiota/Italy/abx_data_john10-19-2020.csv")
  setnames(dt_CART_italy_antibiotics,"P_ID","pid");
  
  dt_CART_italy_antibiotics[, drug_name := tolower(drug_name)]
  dt_CART_italy_antibiotics[, drug_name := gsub("-","_",drug_name)]
  dt_CART_italy_antibiotics[, drug_name := gsub("/","_",drug_name)]
  
  dt_CART_italy_antibiotics[, start_date:=as.Date(start_date,"%m/%d/%y")]
  dt_CART_italy_antibiotics[, stop_date:=as.Date(stop_date,"%m/%d/%y")]
  
  # x=sort(tolower(unique(dt_CART_italy_antibiotics$drug_name)))
  # x=gsub("-","_",x)
  # x=unique(gsub("/","_",x))
  
  drug_name_clean_map = c("amoxicilina_ac.clavulanico"="amoxicillin",
                          "amoxicillin clavulanate"="amoxicillin",
                          "amoxicillin clavulanate _"="amoxicillin",
                          "augmentin"="amoxicillin",
                          "bactrim"="sulfamethoxazole_trimethoprim",
                          "cefixima"="cefixime",
                          "cefixoral"="cefixime",
                          "ceftazidima_avibactam"="ceftazidime",
                          "ceftriaxone vii somministrazione al"="ceftriaxone",
                          "clarithromycin"="clarithromycin",
                          "fosfomicina"="Fosfomycin",
                          "levofloxacina"="levofloxacin",
                          "teicoplanin"="teicoplanin",
                          "tigeciclina"="tigecycline",
                          "trimethoprim_sulfamethoxazole non_sop prophylaxis since diagnosis"="sulfamethoxazole_trimethoprim",
                          "vancomicina"= "vancomycin.pending")
  
  for(i in 1:length(drug_name_clean_map)){
    drug_name_cur = names(drug_name_clean_map)[i];
    drug_name_clean_cur = drug_name_clean_map[i];
    
    dt_CART_italy_antibiotics[drug_name %in% drug_name_cur, drug_name := drug_name_clean_cur];
  }
  
  #Adding sampleid and pid link here
  
  dt_CART_italy_samples = fread("/Volumes/castoricenter/CAR-Tcell_and_Microbiota/Italy/samples/opbg_sampleskey_11092020_with_oligoid.csv")
  setnames(dt_CART_italy_samples,"pt_id","pid")
  #setnames(dt_CART_italy_samples,"SampleID","sampleid")
  #setnames(dt_CART_italy_samples,"OligoID","oligoid")
  
  dt_CART_italy_samples_and_outcome = merge(dt_CART_italy_samples[,.(pid,sampleid,oligoid,timepoint)],
                                            dt_CART_italy_clinical[,.(pid,CR,Tox)],
                                            all.x = T,
                                            by="pid")
  dt_CART_italy_samples_and_outcome[, CR:=.(ifelse(CR==1,"Y","N"))]
  dt_CART_italy_samples_and_outcome[, Tox:=.(ifelse(Tox==1,"Y","N"))]
  
  
}

print("dt_CART_italy_clinical, dt_CART_italy_antibiotics and dt_CART_italy_samples_and_outcome are loaded!")
