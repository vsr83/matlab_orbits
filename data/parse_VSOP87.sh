wget https://ftp.imcce.fr/pub/ephem/planets/vsop87/VSOP87A.mer
wget https://ftp.imcce.fr/pub/ephem/planets/vsop87/VSOP87A.ven
wget https://ftp.imcce.fr/pub/ephem/planets/vsop87/VSOP87A.ear
wget https://ftp.imcce.fr/pub/ephem/planets/vsop87/VSOP87A.mar
wget https://ftp.imcce.fr/pub/ephem/planets/vsop87/VSOP87A.jup
wget https://ftp.imcce.fr/pub/ephem/planets/vsop87/VSOP87A.sat
wget https://ftp.imcce.fr/pub/ephem/planets/vsop87/VSOP87A.ura
wget https://ftp.imcce.fr/pub/ephem/planets/vsop87/VSOP87A.nep
cat VSOP87A.mer | grep -v VSOP | awk '{print substr($0, 2, 4)" "substr($0, 84, 14)" "substr($0, 99, 14)" "substr($0, 114)}' > VSOP87A_mercury.txt
cat VSOP87A.ven | grep -v VSOP | awk '{print substr($0, 2, 4)" "substr($0, 84, 14)" "substr($0, 99, 14)" "substr($0, 114)}' > VSOP87A_venus.txt
cat VSOP87A.ear | grep -v VSOP | awk '{print substr($0, 2, 4)" "substr($0, 84, 14)" "substr($0, 99, 14)" "substr($0, 114)}' > VSOP87A_earth.txt
cat VSOP87A.mar | grep -v VSOP | awk '{print substr($0, 2, 4)" "substr($0, 84, 14)" "substr($0, 99, 14)" "substr($0, 114)}' > VSOP87A_mars.txt
cat VSOP87A.jup | grep -v VSOP | awk '{print substr($0, 2, 4)" "substr($0, 84, 14)" "substr($0, 99, 14)" "substr($0, 114)}' > VSOP87A_jupiter.txt
cat VSOP87A.sat | grep -v VSOP | awk '{print substr($0, 2, 4)" "substr($0, 84, 14)" "substr($0, 99, 14)" "substr($0, 114)}' > VSOP87A_saturn.txt
cat VSOP87A.ura | grep -v VSOP | awk '{print substr($0, 2, 4)" "substr($0, 84, 14)" "substr($0, 99, 14)" "substr($0, 114)}' > VSOP87A_uranus.txt
cat VSOP87A.nep | grep -v VSOP | awk '{print substr($0, 2, 4)" "substr($0, 84, 14)" "substr($0, 99, 14)" "substr($0, 114)}' > VSOP87A_neptune.txt
