

anno = int(input("Inserisci Anno:"))

if anno % 4 == 0 and (anno % 100 !=0 or anno % 400 == 0):
    print("L'anno: ", anno, "e' bisestile")
else:
    print("L'anno: ", anno," non e' bisestile")

