def parity_check(n):
    return bin(n).count('1') % 2

with open('answer.txt', 'w') as f:
    for i in range(2**16):
        f.write(f"{parity_check(i)}\n")