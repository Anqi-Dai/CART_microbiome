#It computes the distance of points to `column-centroid` according to a reference `group` to compute centroid.
#
#

library(data.table);

#source('~/projects/general/library/antoniostats/Fishers_method.R'); #Use Fisher's method to aggregate p-value

euclidean_norm <- function(x){
  return( sqrt(sum(x^2)));
}

centroid_distance = function(M, groups, ref_group=NULL) {
  
  groups = factor(groups);
  
  if(is.null(ref_group)){
    ref_group = levels(groups)[1];
  }
  
  ind_ref = groups==ref_group;
  centroid = apply(M[ind_ref,],2,mean);
  
  M_recentered = t(t(M) - centroid);
  
  dist_to_centroid = sqrt( apply((M_recentered)^2, 1, sum) );
  
  
  d_set = data.table(dist_to_centroid=dist_to_centroid, id=names(dist_to_centroid), groups=groups, ref_group=ref_group);
  return(d_set);
  
}

centroid_distance_selected_rows = function(M, selected_rows, selected_rows_groups, ref_group=NULL) {
  
  if( ! all(selected_rows %in% row.names(M) ) ){
    stop("all selected_row_groups must be in row.names of M");
  }
  
  ind_matrix_selected = row.names(M) %in% selected_rows;
  
  M_selected = M[ind_matrix_selected,ind_matrix_selected];
  
  m_selected_order = merge( data.table(selected_rows_raw_order = rownames(M_selected)),
                            data.table(selected_rows = selected_rows,
                                       selected_rows_order = 1:length(selected_rows)),
                            by.x="selected_rows_raw_order",
                            by.y="selected_rows");
  
  M_selected =M_selected[order(m_selected_order$selected_rows_order),order(m_selected_order$selected_rows_order)];
  #1
  if(! all(row.names(M_selected) == selected_rows) ){
    stop("I expected all row names in M_selected to match selected_rows in proper order.");
  }
  
  d_set = centroid_distance(M_selected, selected_rows_groups, ref_group);
  #d_set$M_selected = M_selected;
  return(d_set);
  
}
