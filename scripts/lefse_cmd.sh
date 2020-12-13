format_input.py I.cr_d30_lefse_ready.tsv  I.cr_d30_lefse_ready.tsv.in -c 1 -u 2 -o 1000000
format_input.py I.toxicity_lefse_ready.tsv  I.toxicity_lefse_ready.tsv.in -c 1 -u 2 -o 1000000
format_input.py M.cr_d30_lefse_ready.tsv  M.cr_d30_lefse_ready.tsv.in -c 1 -u 2 -o 1000000
format_input.py M.toxicity_lefse_ready.tsv  M.toxicity_lefse_ready.tsv.in -c 1 -u 2 -o 1000000
format_input.py P.cr_d30_lefse_ready.tsv  P.cr_d30_lefse_ready.tsv.in -c 1 -u 2 -o 1000000
format_input.py P.toxicity_lefse_ready.tsv  P.toxicity_lefse_ready.tsv.in -c 1 -u 2 -o 1000000
run_lefse.py I.cr_d30_lefse_ready.tsv.in  I.cr_d30_lefse_ready.tsv.res
run_lefse.py I.toxicity_lefse_ready.tsv.in  I.toxicity_lefse_ready.tsv.res
run_lefse.py M.cr_d30_lefse_ready.tsv.in  M.cr_d30_lefse_ready.tsv.res
run_lefse.py M.toxicity_lefse_ready.tsv.in  M.toxicity_lefse_ready.tsv.res
run_lefse.py P.cr_d30_lefse_ready.tsv.in  P.cr_d30_lefse_ready.tsv.res
run_lefse.py P.toxicity_lefse_ready.tsv.in  P.toxicity_lefse_ready.tsv.res
plot_res.py I.cr_d30_lefse_ready.tsv.res I.cr_d30_lefse_ready.tsv.png  --feature_font_size 4 --width 10 --dpi 300
plot_res.py I.toxicity_lefse_ready.tsv.res I.toxicity_lefse_ready.tsv.png  --feature_font_size 4 --width 10 --dpi 300
plot_res.py M.cr_d30_lefse_ready.tsv.res M.cr_d30_lefse_ready.tsv.png  --feature_font_size 4 --width 10 --dpi 300
plot_res.py M.toxicity_lefse_ready.tsv.res M.toxicity_lefse_ready.tsv.png  --feature_font_size 4 --width 10 --dpi 300
plot_res.py P.cr_d30_lefse_ready.tsv.res P.cr_d30_lefse_ready.tsv.png  --feature_font_size 4 --width 10 --dpi 300
plot_res.py P.toxicity_lefse_ready.tsv.res P.toxicity_lefse_ready.tsv.png  --feature_font_size 4 --width 10 --dpi 300
