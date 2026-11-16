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
