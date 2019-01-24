lst = [2, 4, 1, 2, 1, 3, 1, 1, 5]

def pobeg_žabe(sez):
    energ = sez[0]
    for i in range(len(sez) - 1):
        najvecji = max(sez[i:(energ + 1)])
        energ -= sez[i]
    
