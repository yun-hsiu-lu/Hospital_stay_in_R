the.data = read.csv("C:/senic.csv")
boxplot(Length ~ Region, data = the.data, main = "Boxplot of Staying length (in days) by Region")
the.means = aggregate(Length ~ Region, data = the.data, mean)
the.means

# outliers
anova.table = anova(lm(Length ~ Region, data = the.data))
the.model= lm(Length ~ Region, data = the.data)
the.data$ei = the.model$residuals

nt =nrow(the.data)
a = length(unique(the.data$Region))
SSE = sum(the.data$ei^2)
MSE = SSE/(nt-a)
eij.star = the.model$residuals/sqrt(MSE)

alpha =0.05
t.cutoff = qt(1-alpha/(2*nt), nt-a)
C0.eij = which(abs(eij.star) > t.cutoff)
C0.eij

outliers = C0.eij
new.data = the.data[-outliers,]
new.data #remove the outliers
anova_result <- aov(Length ~ Region, data = new.data)
anova_summary <- capture.output(anova_result)
table_output <- capture.output(anova_summary)
writeLines(table_output, "project1.txt")

#tukey multipliers
Tuk1 = qtukey(1-alpha, a, nt-a)/sqrt(2)
# scheffe
sch = sqrt((a-1)*qf(1-alpha, a-1, nt-a))
#bonferroni: I assume g=6 because I make 6 CIs total
g =6
Bon = qt(1-alpha/(2*g), nt-a)
#simultaneous CI
give.me.CI = function(ybar,ni,ci,MSE,multiplier){
  if(sum(ci) != 0 & sum(ci !=0 ) != 1){
    return("Error - you did not input a valid contrast")
  } else if(length(ci) != length(ni)){
    return("Error - not enough contrasts given")
  }
  else{
    estimate = sum(ybar*ci)
    SE = sqrt(MSE*sum(ci^2/ni))
    CI = estimate + c(-1,1)*multiplier*SE
    result = c(estimate,CI)
    names(result) = c("Estimate","Lower Bound","Upper Bound")
    return(result)
  }
}
group.means = by(new.data$Length,new.data$Region,mean)
group.nis = by(new.data$Length,new.data$Region,length)
the.model = lm(Length ~ Region, data = new.data)
anova.table = anova(the.model)
MSE = anova.table[2,3]
nt = sum(group.nis)
a = length(group.means)
alpha = 0.05

#compare mu_1, mu_2
c12 = c(1,-1,0,0)
give.me.CI(group.means,group.nis,c12,MSE,Tuk1)
#compare mu_2, mu_4
c24 = c(0,1,0,-1)
give.me.CI(group.means,group.nis,c24,MSE,Tuk1)
#compare mu_2, mu_3
c23 = c(0,1,-1,0)
give.me.CI(group.means,group.nis,c23,MSE,Tuk1)
#compare mu_1, mu_3
c13 = c(1,0,-1,0)
give.me.CI(group.means,group.nis,c13,MSE,Tuk1)
#compare mu_3, mu_4
c34 = c(0,0,1,-1)
give.me.CI(group.means,group.nis,c34,MSE,Tuk1)
#compare mu_1, mu_4
c14 = c(1,0,0,-1)
give.me.CI(group.means,group.nis,c14,MSE,Tuk1)

