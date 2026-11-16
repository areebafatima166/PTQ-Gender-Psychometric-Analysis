
# ============================================
# PTQ Gender Psychometric Analysis
# Configural Multi-Group CFA
# ============================================

# 1. Load packages
library(haven)
library(lavaan)

# 2. Load authorized dataset
data_file <- "PTQ CFA.sav"

if (!file.exists(data_file)) {
  stop("Please place an authorized copy of PTQ CFA.sav in the working directory.")
}

gender_data <- read_sav(data_file)

# 3. Prepare data
ptq_items <- paste0("PTQ", 1:15)

ptq_numeric <- data.frame(
  lapply(gender_data[ptq_items], as.numeric)
)

gender_group <- factor(
  as.numeric(gender_data$Gender),
  levels = c(1, 2),
  labels = c("Male", "Female")
)

ptq_gender_data <- data.frame(
  ptq_numeric,
  Gender = gender_group
)

print(dim(ptq_gender_data))
print(table(ptq_gender_data$Gender))

# 4. Specify models

one_factor_model <- '
RNT =~ PTQ1 + PTQ2 + PTQ3 + PTQ4 + PTQ5 +
       PTQ6 + PTQ7 + PTQ8 + PTQ9 + PTQ10 +
       PTQ11 + PTQ12 + PTQ13 + PTQ14 + PTQ15
'

original_3factor_model <- '
Core =~ PTQ1 + PTQ2 + PTQ3 + PTQ6 + PTQ7 +
        PTQ8 + PTQ11 + PTQ12 + PTQ13

Unproductiveness =~ PTQ4 + PTQ9 + PTQ14

MentalCapacity =~ PTQ5 + PTQ10 + PTQ15
'

two_factor_model <- '
Core =~ PTQ1 + PTQ2 + PTQ3 + PTQ6 + PTQ7 +
        PTQ8 + PTQ11 + PTQ12 + PTQ13

ProblemThinking =~ PTQ4 + PTQ5 + PTQ9 +
                   PTQ10 + PTQ14 + PTQ15
'

# 5. Fit configural models

fit_one_configural <- cfa(
  one_factor_model,
  data = ptq_gender_data,
  group = "Gender",
  ordered = ptq_items,
  estimator = "WLSMV",
  std.lv = TRUE
)

fit_3factor_gender <- cfa(
  original_3factor_model,
  data = ptq_gender_data,
  group = "Gender",
  ordered = ptq_items,
  estimator = "WLSMV",
  std.lv = TRUE
)

fit_2factor_gender <- cfa(
  two_factor_model,
  data = ptq_gender_data,
  group = "Gender",
  ordered = ptq_items,
  estimator = "WLSMV",
  std.lv = TRUE
)

# 6. Check admissibility

post_checks <- c(
  lavInspect(fit_one_configural, "post.check"),
  lavInspect(fit_3factor_gender, "post.check"),
  lavInspect(fit_2factor_gender, "post.check")
)

# 7. Extract fit statistics

models <- list(
  fit_one_configural,
  fit_3factor_gender,
  fit_2factor_gender
)

fit_results <- lapply(models, function(model) {
  fitMeasures(
    model,
    c("cfi.robust", "tli.robust",
      "rmsea.robust", "srmr")
  )
})

gender_model_comparison <- data.frame(
  Model = c("One-factor", "Three-factor", "Two-factor"),
  Robust_CFI = sapply(fit_results, function(x) x["cfi.robust"]),
  Robust_TLI = sapply(fit_results, function(x) x["tli.robust"]),
  Robust_RMSEA = sapply(fit_results, function(x) x["rmsea.robust"]),
  SRMR = sapply(fit_results, function(x) x["srmr"]),
  Admissible = ifelse(post_checks, "Yes", "No"),
  Post_Check = post_checks
)

print(gender_model_comparison)

# 8. Export results

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

# ============================================
# End of analysis
# ============================================
