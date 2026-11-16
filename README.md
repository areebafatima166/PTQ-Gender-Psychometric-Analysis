# PTQ Gender Psychometric Analysis

## Research purpose
Evaluation of the psychometric structure of the 15-item Perseverative Thinking Questionnaire (PTQ) and exploratory examination of its configural structure across gender.

## Sample
- Total participants: 380
- Male: 190
- Female: 190

## Analysis
- Software: R
- Package: lavaan
- Estimator: WLSMV
- Analysis: Multi-group confirmatory factor analysis
- Models examined: One-factor, original three-factor, and exploratory two-factor

### Main finding

None of the three tested configural models demonstrated adequate robust fit.

| Model | Robust CFI | Robust TLI | Robust RMSEA | SRMR | Admissible |
|---|---:|---:|---:|---:|---|
| One-factor | 0.878 | 0.858 | 0.116 | 0.060 | Yes |
| Original three-factor | 0.894 | 0.873 | 0.110 | 0.055 | No |
| Exploratory two-factor | 0.895 | 0.876 | 0.109 | 0.055 | Yes |

The original three-factor model was inadmissible in the male group because its latent factor covariance matrix was not positive definite.

Measurement invariance testing was not continued because an adequate configural baseline could not be established.
## Instrument reference

The PTQ was developed and validated by Ehring et al. (2011).

Ehring, T., Zetsche, U., Weidacker, K., Wahl, K.,
Schönfeld, S., & Ehlers, A. (2011).
The Perseverative Thinking Questionnaire (PTQ):
Validation of a content-independent measure of
repetitive negative thinking.
Journal of Behavior Therapy and Experimental Psychiatry,
42(2), 225–232.
https://doi.org/10.1016/j.jbtep.2010.12.003
## Data availability and reproducibility

The R analysis script and aggregated model-comparison results are publicly available in this repository. Participant-level data are not included to protect confidentiality and because permission for public data sharing has not been established.

To reproduce the analysis, users must have an authorized copy of the dataset named `PTQ CFA.sav` and the required R packages (`haven` and `lavaan`) installed.

## Limitations

This analysis evaluates configural model structure only. Since none of the tested models demonstrated adequate robust fit, measurement invariance across gender was not examined. The exploratory two-factor model should not be interpreted as a validated alternative PTQ structure. Further independent investigation is needed.
