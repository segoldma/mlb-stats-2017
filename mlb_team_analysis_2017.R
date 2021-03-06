require(dplyr)
require(readr)
require(ggplot2)
require(corrplot)

### Read in 2017 regular season team data
### Data retrieved from https://www.baseball-reference.com/leagues/MLB/2017.shtml

team_batting <- read_csv("Tm,#Bat,BatAge,R/G,G,PA,AB,R,H,2B,3B,HR,RBI,SB,CS,BB,SO,BA,OBP,SLG,OPS,OPS+,TB,GDP,HBP,SH,SF,IBB,LOB
ARI,45,28.3,5.01,162,6224,5525,812,1405,314,39,220,776,103,30,578,1456,.254,.329,.445,.774,93,2457,106,54,39,27,44,1118
                         ATL,49,28.7,4.52,162,6216,5584,732,1467,289,26,165,706,77,31,474,1184,.263,.326,.412,.738,94,2303,137,66,59,32,57,1127
                         BAL,50,28.6,4.59,162,6140,5650,743,1469,269,12,232,713,32,13,392,1412,.260,.312,.435,.747,99,2458,138,50,10,37,12,1041
                         BOS,49,27.3,4.85,162,6338,5669,785,1461,302,19,168,735,106,31,571,1224,.258,.329,.407,.736,92,2305,141,53,9,36,48,1134
                         CHC,47,27.1,5.07,162,6283,5496,822,1402,274,29,223,785,62,31,622,1401,.255,.338,.437,.775,100,2403,134,82,48,32,54,1147
                         CHW,51,26.7,4.36,162,6059,5513,706,1412,256,37,186,670,71,31,401,1397,.256,.314,.417,.731,95,2300,124,76,35,33,17,1055
                         CIN,47,27.1,4.65,162,6213,5484,753,1390,249,38,219,715,120,39,565,1329,.253,.329,.433,.761,98,2372,116,72,50,42,41,1135
                         CLE,41,28.0,5.05,162,6234,5511,818,1449,333,29,212,780,88,23,604,1153,.263,.339,.449,.788,104,2476,125,50,23,45,30,1158
                         COL,41,28.3,5.09,162,6201,5534,824,1510,293,38,192,793,59,34,519,1408,.273,.338,.444,.781,91,2455,143,44,62,41,46,1088
                         DET,49,29.6,4.54,162,6150,5556,735,1435,289,35,187,699,65,34,503,1313,.258,.324,.424,.748,96,2355,128,52,11,27,21,1104
                         HOU,46,28.8,5.53,162,6271,5611,896,1581,346,20,238,854,98,42,509,1087,.282,.346,.478,.823,127,2681,139,70,11,61,27,1094
                         KCR,49,28.9,4.33,162,6027,5536,702,1436,260,24,193,660,91,31,390,1166,.259,.311,.420,.731,92,2323,160,45,17,37,19,1005
                         LAA,55,30.0,4.38,162,6073,5415,710,1314,251,14,186,678,136,44,523,1198,.243,.315,.397,.712,93,2151,141,70,17,46,30,1033
                         LAD,52,27.9,4.75,162,6191,5408,770,1347,312,20,221,730,77,28,649,1380,.249,.334,.437,.771,103,2362,119,64,31,38,41,1146
                         MIA,43,28.4,4.80,162,6248,5602,778,1497,271,31,194,743,91,30,486,1282,.267,.331,.431,.761,104,2412,119,67,50,41,48,1130
                         MIL,50,27.4,4.52,162,6135,5467,732,1363,267,22,224,695,128,41,547,1571,.249,.322,.429,.751,95,2346,116,53,42,26,34,1088
                         MIN,52,27.0,5.03,162,6261,5557,815,1444,286,31,206,781,95,28,593,1342,.260,.334,.434,.768,105,2410,105,46,26,39,26,1147
                         NYM,52,28.8,4.54,162,6169,5510,735,1379,286,28,224,713,58,23,529,1291,.250,.320,.434,.755,98,2393,118,57,36,37,31,1099
                         NYY,51,28.6,5.30,162,6354,5594,858,1463,266,23,241,821,90,22,616,1386,.262,.339,.447,.785,105,2498,119,64,18,56,22,1184
                         OAK,54,28.7,4.56,162,6126,5464,739,1344,305,15,234,708,57,22,565,1491,.246,.319,.436,.755,103,2381,129,43,13,40,15,1075
                         PHI,51,26.6,4.26,162,6133,5535,690,1382,287,36,174,654,59,25,494,1417,.250,.315,.409,.723,91,2263,128,47,21,36,25,1079
                         PIT,47,28.2,4.12,162,6136,5458,668,1331,249,36,151,635,67,36,519,1213,.244,.318,.386,.704,84,2105,120,88,42,28,39,1129
                         SDP,52,26.2,3.73,162,5954,5356,604,1251,227,31,189,576,89,33,460,1499,.234,.299,.393,.692,84,2107,99,53,52,33,20,1037
                         SEA,61,29.5,4.63,162,6166,5551,750,1436,281,17,200,714,89,35,487,1267,.259,.325,.424,.749,101,2351,131,78,14,35,31,1084
                         SFG,49,29.5,3.94,162,6137,5551,639,1382,290,28,128,612,76,34,467,1204,.249,.309,.380,.689,83,2112,136,36,31,52,37,1093
                         STL,48,28.0,4.70,162,6219,5470,761,1402,284,28,196,728,81,31,593,1348,.256,.334,.426,.760,99,2330,139,65,47,44,36,1118
                         TBR,53,28.3,4.28,162,6147,5478,694,1340,226,32,228,671,88,34,545,1538,.245,.317,.422,.739,101,2314,115,55,16,48,33,1114
                         TEX,51,28.3,4.93,162,6122,5430,799,1326,255,21,237,756,113,44,544,1493,.244,.320,.430,.750,93,2334,110,81,27,39,18,1015
                         TOR,60,30.9,4.28,162,6154,5499,693,1320,269,5,222,661,53,24,542,1327,.240,.312,.412,.724,88,2265,153,51,25,35,12,1064
                         WSN,49,29.2,5.06,162,6214,5553,819,1477,311,31,215,796,108,30,542,1327,.266,.332,.449,.782,100,2495,116,31,43,45,56,1101
                         LgAvg,45,28.3,4.65,162,6177,5519,753,1407,280,27,204,719,84,31,528,1337,.255,.324,.426,.750,97,2351,127,59,31,39,32,1098
                         ,1358,28.3,4.65,4860,185295,165567,22582,42215,8397,795,6105,21558,2527,934,15829,40104,.255,.324,.426,.750,97,70517,3804,1763,925,1168,970,32942")


team_pitching <- read_csv("Tm,#P,PAge,RA/G,W,L,W-L%,ERA,G,GS,GF,CG,tSho,cSho,SV,IP,H,R,ER,HR,BB,IBB,SO,HBP,BK,WP,BF,ERA+,FIP,WHIP,H9,HR9,BB9,SO9,SO/W,LOB
ARI,23,28.7,4.07,93,69,.574,3.66,162,162,160,2,11,1,43,1441.0,1309,659,586,171,516,45,1482,38,5,82,6072,131,3.80,1.266,8.2,1.1,3.2,9.3,2.87,1090
                          ATL,26,29.4,5.07,72,90,.444,4.72,162,162,162,0,6,0,36,1441.1,1463,821,756,192,584,39,1258,70,5,58,6306,91,4.51,1.420,9.1,1.2,3.6,7.9,2.15,1161
                          BAL,26,28.2,5.19,75,87,.463,4.97,162,162,161,1,10,1,35,1441.0,1505,841,795,242,579,21,1233,60,6,53,6293,88,4.96,1.446,9.4,1.5,3.6,7.7,2.13,1129
                          BOS,27,28.4,4.12,93,69,.574,3.70,162,162,157,5,11,1,39,1482.1,1384,668,610,195,465,18,1580,49,3,43,6217,123,3.78,1.247,8.4,1.2,2.8,9.6,3.40,1102
                          CHC,28,30.8,4.29,92,70,.568,3.95,162,162,160,2,8,1,38,1447.1,1294,695,636,194,554,29,1439,66,4,73,6108,111,4.20,1.277,8.0,1.2,3.4,8.9,2.60,1071
                          CHW,31,28.7,5.06,67,95,.414,4.78,162,162,162,0,3,0,25,1421.2,1384,820,755,242,632,36,1193,68,5,67,6200,90,5.17,1.418,8.8,1.5,4.0,7.6,1.89,1115
                          CIN,31,27.6,5.36,68,94,.420,5.17,162,162,160,2,8,1,33,1430.0,1442,869,821,248,631,37,1300,77,7,62,6286,85,5.08,1.450,9.1,1.6,4.0,8.2,2.06,1127
                          CLE,20,28.9,3.48,102,60,.630,3.30,162,162,155,7,19,3,37,1440.2,1267,564,529,163,406,15,1614,45,1,48,5866,138,3.33,1.161,7.9,1.0,2.5,10.1,3.98,980
                          COL,21,27.0,4.67,87,75,.537,4.51,162,162,161,1,9,1,47,1437.2,1453,757,721,190,532,20,1270,50,10,69,6177,111,4.32,1.381,9.1,1.2,3.3,8.0,2.39,1107
                          DET,29,28.3,5.52,64,98,.395,5.36,162,162,160,2,4,1,32,1420.1,1587,894,846,218,538,42,1202,61,4,53,6298,85,4.73,1.496,10.1,1.4,3.4,7.6,2.23,1143
                          HOU,27,28.5,4.32,101,61,.623,4.12,162,162,161,1,9,0,45,1446.0,1314,700,662,192,522,17,1593,70,4,86,6111,96,3.91,1.270,8.2,1.2,3.2,9.9,3.05,1073
                          KCR,29,30.3,4.88,80,82,.494,4.61,162,162,161,1,6,1,39,1437.2,1480,791,737,196,519,24,1216,52,6,48,6218,97,4.43,1.390,9.3,1.2,3.2,7.6,2.34,1114
                          LAA,31,29.1,4.38,80,82,.494,4.20,162,162,161,1,10,1,43,1440.2,1373,709,672,224,470,25,1312,44,6,57,6030,101,4.43,1.279,8.6,1.4,2.9,8.2,2.79,999
                          LAD,26,29.7,3.58,104,58,.642,3.38,162,162,160,2,16,0,51,1444.2,1226,580,543,184,442,33,1549,40,10,40,5925,124,3.67,1.155,7.6,1.1,2.8,9.6,3.50,1011
                          MIA,24,28.7,5.07,77,85,.475,4.82,162,162,161,1,7,1,34,1442.2,1450,822,772,193,627,59,1202,75,3,57,6318,85,4.69,1.440,9.0,1.2,3.9,7.5,1.92,1168
                          MIL,30,28.3,4.30,86,76,.531,4.00,162,162,161,1,12,0,54,1445.2,1381,697,642,185,553,45,1346,64,2,50,6164,110,4.24,1.338,8.6,1.2,3.4,8.4,2.43,1130
                          MIN,36,29.6,4.86,85,77,.525,4.59,162,162,156,6,11,3,42,1436.0,1487,788,732,224,483,37,1166,69,8,52,6205,96,4.72,1.372,9.3,1.4,3.0,7.3,2.41,1109
                          NYM,29,27.5,5.33,70,92,.432,5.01,162,162,160,2,5,0,34,1434.2,1538,863,799,220,593,51,1374,55,5,55,6378,85,4.59,1.485,9.6,1.4,3.7,8.6,2.32,1211
                          NYY,25,27.8,4.07,91,71,.562,3.72,162,162,160,2,7,1,36,1448.2,1248,660,599,192,504,18,1560,53,4,83,6078,121,3.88,1.209,7.8,1.2,3.1,9.7,3.10,1072
                          OAK,28,27.9,5.10,75,87,.463,4.68,162,162,161,1,6,1,35,1431.0,1444,826,744,210,502,17,1202,61,3,84,6167,91,4.57,1.360,9.1,1.3,3.2,7.6,2.39,1048
                          PHI,31,26.8,4.83,66,96,.407,4.55,162,162,161,1,7,0,33,1441.0,1471,782,729,221,527,39,1309,63,11,50,6235,93,4.56,1.387,9.2,1.4,3.3,8.2,2.48,1130
                          PIT,24,27.1,4.51,75,87,.463,4.22,162,162,160,2,12,1,36,1440.2,1464,731,676,182,511,32,1262,58,2,58,6208,102,4.23,1.371,9.1,1.1,3.2,7.9,2.47,1155
                          SDP,32,27.7,5.04,71,91,.438,4.67,162,162,160,2,12,1,45,1430.2,1417,816,742,226,554,28,1325,75,11,73,6169,88,4.67,1.378,8.9,1.4,3.5,8.3,2.39,1061
                          SEA,40,27.8,4.77,78,84,.481,4.46,162,162,161,1,9,0,39,1440.1,1399,772,713,237,490,28,1244,53,7,73,6132,96,4.70,1.312,8.7,1.5,3.1,7.8,2.54,1039
                          SFG,22,28.9,4.79,64,98,.395,4.50,162,162,159,3,5,2,32,1452.0,1515,776,726,182,496,42,1234,50,3,55,6287,94,4.22,1.385,9.4,1.1,3.1,7.6,2.49,1155
                          STL,25,28.3,4.35,83,79,.512,4.01,162,162,159,3,12,3,43,1450.1,1393,705,646,183,493,50,1351,67,0,38,6153,107,4.09,1.300,8.6,1.1,3.1,8.4,2.74,1097
                          TBR,30,27.6,4.35,80,82,.494,3.97,162,162,162,0,9,0,53,1445.0,1324,704,638,193,503,37,1352,48,4,83,6099,105,4.17,1.264,8.2,1.2,3.1,8.4,2.69,1060
                          TEX,31,28.8,5.04,78,84,.481,4.66,162,162,160,2,6,1,29,1434.1,1443,816,742,214,559,22,1107,74,7,63,6211,100,4.88,1.396,9.1,1.3,3.5,6.9,1.98,1092
                          TOR,33,28.8,4.84,76,86,.469,4.42,162,162,160,2,6,0,45,1465.0,1460,784,720,203,549,25,1372,48,4,53,6316,105,4.31,1.371,9.0,1.2,3.4,8.4,2.50,1137
                          WSN,24,30.1,4.15,97,65,.599,3.88,162,162,159,3,5,1,46,1446.2,1300,672,623,189,495,39,1457,60,5,44,6068,115,3.99,1.241,8.1,1.2,3.1,9.1,2.94,1056
                          LgAvg,25,28.5,4.65,81,81,.500,4.35,162,162,160,2,,,39,1442,1407,753,697,204,528,32,1337,59,5,60,6177,101,4.36,1.342,8.8,1.3,3.3,8.3,2.53,1098
                          ,755,28.5,4.65,2430,2430,.500,4.35,4860,4860,4801,59,,,1179,43257.0,42215,22582,20912,6105,15829,970,40104,1763,155,1810,185295,101,4.36,1.342,8.8,1.3,3.3,8.3,2.53,32942")

## Add team leagues
team_league <- read_csv("team_leagues.csv")

## Remove summary rows
team_batting <- team_batting %>%
  slice(1:30) %>%
  left_join(team_league, by = "Tm")

team_pitching <- team_pitching %>%
  slice(1:30) %>%
  left_join(team_league, by = "Tm")


### Number of Position Players and Pitchers Used + AL/NL tables
teams_playersused_wins <- left_join(team_batting, team_pitching, by = c("Tm", "Lg")) %>%
  select(Tm, "n_batters" =`#Bat`, "n_pitchers" = `#P`, W, Lg)

al_team_playersused <- teams_playersused_wins %>%
  filter(Lg == "AL")

nl_team_playersused <- teams_playersused_wins %>%
  filter(Lg == "NL")

#histogram of batters used
ggplot(teams_playersused_wins, aes(x = n_batters)) +
  geom_histogram(binwidth = 2)

# Box plot of batters used
ggplot(teams_playersused_wins, aes(x = "", y = n_batters)) +
  geom_boxplot(fill = "#4271AE", width = 0.1) +
  ylab("Number of Batters Used") +
  xlab("") +
  ggtitle("Number of Batters Used in Games")

# Boxplot of batters used faceted by League
ggplot(teams_playersused_wins, aes(x = Lg, y = n_batters)) +
  geom_boxplot(fill = "#4271AE", width = 0.25) +
  xlab("League") +
  ylab("Batters Used") +
  ggtitle("Number of Batters Used in Games")
 

# Which teams used the most batters in each league
teams_playersused_wins %>%
  select(Tm, n_batters, Lg) %>%
  filter(Lg == "AL") %>%
  arrange(desc(n_batters)) %>%
  top_n(5, n_batters)

teams_playersused_wins %>%
  select(Tm, n_batters, Lg) %>%
  filter(Lg == "NL") %>%
  arrange(desc(n_batters)) %>%
  top_n(5, (n_batters))
  
# Plot Relationship between Number of Batters Used and Wins by League
teams_playersused_wins %>%
  select(n_batters, Lg, W) %>%
  ggplot(aes(x = n_batters, y = W, colour = Lg)) +
  geom_point() +
  geom_smooth(method = lm, fullrange = TRUE, se = FALSE) +
  xlab("Team Number of Batters Used in 2017") +
  ylab("Team Wins") +
  ggtitle("Team Batters vs. Wins")

#Weak Negative Correlation between number of batters used and Wins
cor(teams_playersused_wins$n_batters, teams_playersused_wins$W)
cor(al_team_playersused$n_batters, al_team_playersused$W)
cor(nl_team_playersused$n_batters, nl_team_playersused$W)

## Weak Negative Correlation between number of pitchers used and wins
cor(teams_playersused_wins$n_pitchers, teams_playersused_wins$W)
cor(al_team_playersused$n_pitchers, al_team_playersused$W)
cor(nl_team_playersused$n_pitchers, nl_team_playersused$W)

## Import Injury Data
## src: http://www.spotrac.com/mlb/disabled-list/

team_injuries <- read_csv("team_disabled_list.csv")
team_injuries <- left_join(team_injuries, teams_playersused_wins, by = "Tm")

## Examine relationships between batters/pitchers used vs. disabled list stints
injury_cor <- team_injuries %>%
  rename("Tm" = Tm, 
         "Lg" = Lg, 
         "Number of Players on DL" = players_on_dl,
         "Total Days on DL" = days_on_dl,
         "Number of Position Players on DL" = dl_batters,
         "Days Position Players spent on DL" = days_dl_batters,
         "Number of Pitchers on DL" = dl_pitchers,
         "Days Pitchers spent on DL" = days_dl_pitchers,
         "Number of Batters Used" = n_batters,
         "Number of Pitchers Used" = n_pitchers,
         "Team Wins" = W) %>%
  select(-Tm, -Lg) %>%
  cor()
  

corrplot(injury_cor, method="shade", shade.col= NA, tl.col="black", tl.srt=45,
          addCoef.col="black", order="AOE")

#Create correlation coefficient matrix for pitchers  
pitcher_injury_cor <- team_injuries %>%
   select("# Pitchers on DL" = dl_pitchers,
         "Days on DL" = days_dl_pitchers,
         "# Pitchers Used" = n_pitchers,
         "Team Wins" = W) %>%
    cor()

corrplot(pitcher_injury_cor, method="shade", type = "upper", shade.col= NA, tl.col="black", tl.srt=25,
         addCoef.col="black", order="AOE", title = "Pitchers on DL in 2017")

#Create correlation coefficient matrix for batters
batter_injury_cor <- team_injuries %>%
  select( "# Position Players on DL" = dl_batters,
          "Days on DL" = days_dl_batters,
          "# Batters Used" = n_batters,
          "Team Wins" = W) %>%
  cor()

corrplot(batter_injury_cor, method="shade", type = "upper", shade.col= NA, tl.col="black", tl.srt=25,
         addCoef.col="black", order="AOE", title = "Position Players on DL in 2017")

### Add OBP to the batter injury table

batter_injury_with_team_obp <- left_join(team_injuries, team_batting, by = "Tm") %>%
  select( "# Position Players on DL" = dl_batters,
          "Runs per Game" = `R/G`,
          "Days on DL" = days_dl_batters,
          "# Batters Used" = n_batters,
          "Team Wins" = W,
          "OBP" = OBP) %>%
  cor()

batter_injury_with_team_obp

### Add WHIP to the pitching injury table
pitcher_injury_with_team_whip <- team_injuries %>%
  rename("Team Wins" = W) %>%
  left_join(team_pitching, by = "Tm") %>%
  select("# Pitchers on DL" = dl_pitchers,
         "Days on DL" = days_dl_pitchers,
         "# Pitchers Used" = n_pitchers,
         "Team Wins" = W,
         "WHIP" = WHIP) %>%
  cor()

pitcher_injury_with_team_whip

### Questions
## players used vs time on DL
## batters used vs Team OBP
## pitchers used vs Team WHIP


##
##538 on LAD leveraging new DL Rules: https://fivethirtyeight.com/features/how-the-dodgers-are-using-baseballs-new-dl-rules-to-get-an-edge/
##

pitching_all_cats_wins <- team_pitching %>%
  select(-Tm,-G, -GS, -Lg, -PAge, -L, -`W-L%`, -tSho, -cSho, -SV)

p_cor <- cor(x = pitching_all_cats_wins$W, y = pitching_all_cats_wins[1:27], use = "complete.obs")

corrplot(p_cor, method="shade", shade.col= NA, tl.col="black", tl.srt=25,
         addCoef.col="black")

batter_injury_with_team_obp_top <- left_join(team_injuries, team_batting, by = "Tm") %>%
  filter(Tm %in% c("CLE","HOU", "BOS")) %>%
    select("Runs per Game" = `R/G`,
           "OBP" = OBP,
           "Days on DL" = days_dl_batters,
          "Team Wins" = W) %>%
  cor()

(batter_injury_with_team_obp_top) 

corrplot(batter_injury_with_team_obp_top, method="shade", type = "upper", shade.col= NA, tl.col="black", tl.srt=45,
         addCoef.col="black", order="AOE")
