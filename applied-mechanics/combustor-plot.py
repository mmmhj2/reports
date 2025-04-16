
DATA = [
    ['J57' , '美国' , 1950 , 870 , 52.0 , 76.5],
    ['J79' , '美国' , 1955 , 935 , 52.8 , 80.0],
    ['R-11' , '苏联' , 1956 , 955 , 38.7 , 60.6],
    ['TF30' , '美国' , 1960 , 1170 , 64.8 , 111.7],
    ['AL-21F' , '苏联' , 1966 , 1100 , 76.4 , 109.8],
    ['R-29' , '苏联' , 1972 , 1083 , 78.5 , 112.8],
    ['M52' , '法国' , 1974 , 1327 , 64.0 , 95.0],
    ['AL-31F' , '苏联' , 1981 , 1392 , 76.5 , 122.6],
    ['F119' , '美国' , 1986 , 1649 , 116.0 , 156.0],
    ['M88' , '法国' , 1986 , 1577 , 50.0 , 75.0],
    ['AL-41F' , '苏/俄' , 2001 , 1642 , 117.6 , 176.4],
    ['涡扇-15' , '中国' , 2006 , 1568 , 105.0 , 156.0],
    ['F135' , '美国' , 2009 , 1980 , 125.0 , 191.0]
]

import matplotlib.pyplot as plt

plt.rcParams["font.family"] = "SimSun"
years = [x[2] for x in DATA]
temperatures = [x[3] for x in DATA]
nominal_thrust = [x[4] for x in DATA]
afterburnt_thrust = [x[5] for x in DATA]
names = [x[0] for x in DATA]

plt.scatter(years, temperatures, c='red', marker='x')
for x, y, s in zip(years, temperatures, names):
    plt.text(x, y, s)
plt.xlabel('年份')
plt.ylabel('涡轮前温度（℃）')
plt.savefig('combustor-tit.pdf', format='pdf', bbox_inches='tight')
plt.clf()

plt.scatter(years, nominal_thrust, c='red', marker='x')
plt.scatter(years, afterburnt_thrust, c='blue', marker='x')
plt.legend(['正常推力', '加力推力'])
for x, y, s in zip(years, nominal_thrust, names):
    plt.text(x,y,s)
for x, y, s in zip(years, afterburnt_thrust, names):
    plt.text(x,y,s)
plt.xlabel('年份')
plt.ylabel('推力（kN）')
plt.savefig('combustor-thrust.pdf', format='pdf', bbox_inches='tight')
plt.show()

