# Investigating Factors Influencing Internet Usage Using STATA

This analysis explores the factors influencing **Information and Communications Technology (ICT) growth**, measured by access to the internet, as an outcome shaped by social, economic, and political factors. Using a combined panel dataset of **218 countries (1990–2010)**, it examines the impacts of **educational inequality**, **political competition**, **GDP per capita**, and **foreign direct investment (FDI)**.

Results show that economic prosperity and inflows of FDI boost ICT adoption, while educational inequality exacerbates digital divides. Reduced political competition correlates with broader ICT penetration, highlighting the role of governance in shaping digital access. The findings emphasize addressing structural inequalities, fostering inclusive policies, and promoting FDI to bridge global digital divides and advance sustainable ICT expansion.

📄 **Script:** [`InternetUsage_Analysis.do`](InternetUsage_Analysis.do)
🌐 **Portfolio write-up:** [arigourumsah.github.io/projects/ict_growth.html](https://arigourumsah.github.io/projects/ict_growth.html)

---

## Table of Contents

- [Tools](#tools)
- [Dataset](#dataset)
- [Descriptive Statistics](#descriptive-statistics)
- [Visualizing the Data](#visualizing-the-data)
- [Methodology](#methodology)
- [Statistical Analysis](#statistical-analysis)
  - [Main Model](#main-model)
  - [Robustness Checks](#robustness-checks)
  - [Periodical Models](#periodical-models)
  - [Regional Models](#regional-models)
- [Conclusion](#conclusion)
- [Contact](#contact)

---

## Tools

- **STATA** – data cleaning, panel regression, and visualization

## Dataset

The dataset is a country-year panel covering 218 countries from 1990 to 2010, used to investigate the factors influencing internet usage growth.

| Variable | Description |
|---|---|
| Internet usage | Share of the population using the internet (dependent variable) |
| Educational inequality | Gini coefficient of education |
| Political competition | Index of political competition |
| GDP per capita | Economic development / individual affordability |
| FDI net inflows | Foreign direct investment inflows |

![Dataset](https://arigourumsah.github.io/images/ict_growth/dataset.png)

## Descriptive Statistics

![Descriptive Statistics](https://arigourumsah.github.io/images/ict_growth/descriptive_statistics.png)

**Key insights:**

- **Internet Usage** – The wide range and high standard deviation reveal significant disparities in internet penetration across regions and time periods, presenting an opportunity for in-depth analysis of the digital divide.
- **Educational Inequality** – Moderate average levels of inequality with substantial variation, allowing robust analysis of how educational disparities affect internet adoption.
- **Political Competition** – The unusual range and high standard deviation suggest outliers and extreme cases in political environments, requiring careful treatment in the analysis.
- **GDP per Capita** – Wide range and high standard deviation indicate significant disparities in economic prosperity across countries and years.
- **Foreign Direct Investment (FDI)** – Substantial variation in inflows across countries and years, allowing a comprehensive analysis of how FDI influences internet adoption.

## Visualizing the Data

### Growth of Internet Usage Across Regions

![Growth of Internet Usage Across Regions](https://arigourumsah.github.io/images/ict_growth/internet_usage_graph.png)

While regions like Western Europe and North America have achieved near-universal internet access, others, particularly Sub-Saharan Africa, continue to face significant connectivity gaps. The exponential growth in East Asia underscores the transformative impact of strategic investments and policies aimed at digital inclusion. These trends highlight both progress and persistent disparities, emphasizing the need for targeted strategies to bridge the global digital divide.

### Relationships Between Internet Usage and Different Factors

#### Educational Inequality

![Educational Inequality vs Internet Usage](https://arigourumsah.github.io/images/ict_growth/relationship_edu_ineq.png)

There is a negative correlation between educational inequality (Gini coefficient) and internet usage. Countries with lower inequality exhibit higher adoption rates, highlighting the role of equitable education in promoting digital literacy and access. Variability among countries with similar inequality levels suggests that infrastructure, income, and policy also matter.

#### Political Competition

![Political Competition vs Internet Usage](https://arigourumsah.github.io/images/ict_growth/relationship_polcomp.png)

A positive correlation is observed between political competition and internet usage. Democratic systems with higher political competition tend to foster greater digital inclusion through infrastructure investments and inclusive policies, while authoritarian or unstable regimes often show lower connectivity due to restricted access or inadequate infrastructure.

#### GDP per Capita

![GDP per Capita vs Internet Usage](https://arigourumsah.github.io/images/ict_growth/relationship_gdppc.png)

Economic development strongly correlates with internet usage. Wealthier nations achieve near-universal connectivity thanks to affordability, accessibility, and robust infrastructure. Disparities among countries with similar GDP levels point to the influence of governance, infrastructure quality, and regulation.

#### Foreign Direct Investment

![FDI vs Internet Usage](https://arigourumsah.github.io/images/ict_growth/relationship_fdi.png)

FDI inflows positively correlate with internet adoption, emphasizing the role of external investment in funding infrastructure and technological growth. Variability at higher FDI levels indicates that effectiveness depends on governance quality and sectoral allocation.

## Methodology

To analyze the factors influencing internet usage, a **fixed-effects panel regression model** was employed:

![Methodology](https://arigourumsah.github.io/images/ict_growth/methodology.png)

This approach accounts for unobserved heterogeneity across countries and over time, ensuring robust insights into the relationships between variables.

## Statistical Analysis

![Main Model with Robustness Checks and Periodical Models](https://arigourumsah.github.io/images/ict_growth/main_results.png)

### Main Model

| Variable | Effect on internet usage |
|---|---|
| Educational inequality | +1 unit in the Gini coefficient → **+0.773 pp** |
| Political competition | +1 unit → **−0.031 pp** |
| GDP per capita | +$1,000 → **+3.245 pp** |
| FDI net inflows | +$1 billion → **+0.054 pp** |

- **Educational Inequality** – In unequal societies, internet access is often concentrated among privileged groups, reinforcing digital divides.
- **Political Competition** – The negative effect may reflect policy instability in competitive environments, or strategic internet adoption in less democratic regimes for control purposes.
- **GDP per Capita** – Wealthier nations benefit from better infrastructure, affordability, and access.
- **FDI** – Foreign investment enhances digital infrastructure and connectivity.

The results highlight the interplay between socioeconomic and political factors in global internet adoption. Policies promoting equitable education are essential to address digital divides, political stability may be more conducive to digital adoption than political competition, and economic development and international investment are critical for advancing digital inclusion.

### Robustness Checks

Alternative specifications and control variables were used to test the reliability of the main results.

1. **Political Competition → Liberal Democracy Index** – The replacement variable is not statistically significant, suggesting that narrower measures of political competition better capture the relationship with internet usage. Educational inequality, GDP per capita, and FDI remain significant.
2. **GDP per Capita → GDP** – GDP is not significant, affirming that GDP per capita is a better predictor because it reflects individual affordability. Educational inequality, political competition, and FDI remain significant.
3. **Time-lagged Internet Usage** – The lagged dependent variable is highly significant, meaning previous usage strongly influences current levels. Political competition and FDI lose significance.
4. **First- and Second-Differences of Internet Usage** – The first difference is positive and significant (momentum in adoption); the second difference is negative and significant (deceleration as adoption nears saturation). Educational inequality, GDP per capita, and FDI remain robust predictors.

The robustness checks validate the main model and highlight the dynamic nature of global internet adoption.

### Periodical Models

The dataset was split into **1991–2000** and **2001–2010** to see how the determinants evolved during the early phases of global adoption.

| Variable | 1991–2000 | 2001–2010 |
|---|---|---|
| Educational inequality | Significant, but smaller influence: early access was restricted to affluent, educated groups regardless of inequality | Positive and highly significant: access increasingly concentrated among privileged groups |
| Political competition | Insignificant | Insignificant (consistent with earlier period) |
| GDP per capita | Positive and significant | Still key, but smaller magnitude as access costs fell |
| FDI net inflows | Positive and significant | Lower coefficient, reflecting a shift toward domestic investment as infrastructure matured |

The rising significance of educational inequality emphasizes the need for equitable policies, while the diminishing role of FDI reflects a shift toward self-sustaining infrastructure investment. Economic development remains a cornerstone of digital growth, though its influence waned as affordability improved.

### Regional Models

The determinants were re-estimated for nine geopolitical regions.

![Regional Models](https://arigourumsah.github.io/images/ict_growth/regional_results.png)

| Region | Key findings |
|---|---|
| Eastern Europe & Central Asia | Educational inequality negative & significant; GDP per capita positive & significant; FDI insignificant |
| Latin America | Educational inequality, GDP per capita, and FDI all positive & significant |
| North Africa & Middle East | Only FDI positive & significant; other variables insignificant |
| Sub-Saharan Africa | Educational inequality positive & significant (smaller effect); political competition negative & significant; GDP per capita & FDI positive & significant |
| Western Europe & North America | Most variables insignificant due to high penetration; FDI positive but weakly significant |
| East Asia | Educational inequality positive & highly significant; political competition positive & significant |
| Southeast Asia | GDP per capita positive & significant; others insignificant |
| South Asia | GDP per capita positive & significant (smaller effect); others insignificant |
| Caribbean | GDP per capita positive & significant; others insignificant |

**Takeaways:**

- **GDP per capita** is the most consistent determinant across regions, varying in magnitude with economic conditions.
- **Educational inequality** matters most where digital divides are pronounced (e.g., Latin America, East Asia) and has minimal effect in highly connected regions.
- **Political competition** is context-dependent: positive in East Asia, negative in Sub-Saharan Africa.
- **FDI** is critical for developing regions such as Sub-Saharan Africa and Latin America, but less impactful in mature economies.

## Conclusion

Internet adoption is shaped by a mix of economic, social, and political forces. Addressing educational inequality, fostering economic growth, encouraging foreign investment, and accounting for historical adoption trends, with strategies tailored to each region, are key to bridging the global digital divide.

## Contact

**Bintang Arigo Kautsar Urumsah**
📍 Budapest, Hungary
✉️ [arigourumsah@gmail.com](mailto:arigourumsah@gmail.com)
🔗 [LinkedIn](https://www.linkedin.com/in/bintang-arigo-k-urumsah/) · [GitHub](https://github.com/arigourumsah) · [Portfolio](https://arigourumsah.github.io/)
