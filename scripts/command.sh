humann2_barplot  \
    --input $1 \
    --focal-feature $2 \
    --sort similarity metadata \
    --focal-metadatum Toxicity \
    --last-metadatum Toxicity \
    --scaling pseudolog \
    --dimensions 10 5 \
    -o $2.png
