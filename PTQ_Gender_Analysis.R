# =====================================
# PTQ Gender Analysis
# Configural Model Specifications
# =====================================

# One-factor model
one_factor_model <- '
RNT =~ PTQ1 + PTQ2 + PTQ3 + PTQ4 + PTQ5 +
       PTQ6 + PTQ7 + PTQ8 + PTQ9 + PTQ10 +
       PTQ11 + PTQ12 + PTQ13 + PTQ14 + PTQ15
'

# Original three-factor model
original_3factor_model <- '
Core =~ PTQ1 + PTQ2 + PTQ3 + PTQ6 + PTQ7 +
        PTQ8 + PTQ11 + PTQ12 + PTQ13

Unproductiveness =~ PTQ4 + PTQ9 + PTQ14

MentalCapacity =~ PTQ5 + PTQ10 + PTQ15
'

# Exploratory two-factor model
two_factor_model <- '
Core =~ PTQ1 + PTQ2 + PTQ3 + PTQ6 + PTQ7 +
        PTQ8 + PTQ11 + PTQ12 + PTQ13

ProblemThinking =~ PTQ4 + PTQ5 + PTQ9 +
                   PTQ10 + PTQ14 + PTQ15
'
# =====================================
# Model comparison and export
# =====================================

gender_model_comparison <- data.frame(
  Model = c("One-factor", "Three-factor", "Two-factor"),
  Robust_CFI = c(.878, .894, .895),
  Robust_TLI = c(.858, .873, .876),
  Robust_RMSEA = c(.116, .110, .109),
  SRMR = c(.060, .055, .055),
  Admissible = c("Yes", "No", "Yes"),
  Post_Check = c(
    lavInspect(fit_one_configural, "post.check"),
    lavInspect(fit_3factor_gender, "post.check"),
    lavInspect(fit_2factor_gender, "post.check")
  )
)

print(gender_model_comparison)

write.csv(
  gender_model_comparison,
  "PTQ_Gender_Configural_Model_Comparison.csv",
  row.names = FALSE
)

saveRDS(
  list(
    one_factor = fit_one_configural,
    three_factor = fit_3factor_gender,
    two_factor = fit_2factor_gender,
    comparison = gender_model_comparison
  ),
  "PTQ_gender_analysis_results.rds"
)
# =====================================
# Research notes
# =====================================

# Sample size: N = 380
# Male: 190
# Female: 190
# Number of PTQ items: 15
# Response categories: 0-4
# Estimator: WLSMV
#
# Important finding:
# None of the tested configural models showed
# adequate robust fit.
#
# Measurement invariance testing was not continued
# because an adequate configural baseline
# could not be established.
# =====================================
# Load and prepare the dataset
# =====================================

library(haven)
library(lavaan)

gender_data <- read_sav(
  "C:/Users/PMLS/Desktop/MS  theises data/PTQ CFA.sav"
)

ptq_items <- paste0("PTQ", 1:15)

ptq_numeric <- data.frame(
  lapply(gender_data[ptq_items], as.numeric)
)

gender_group <- factor(
  gender_data$Gender,
  levels = c(1, 2),
  labels = c("Male", "Female")
)

ptq_gender_data <- data.frame(
  ptq_numeric,
  Gender = gender_group
)

# Check the sample
dim(ptq_gender_data)
table(ptq_gender_data$Gender)