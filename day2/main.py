with open("input.txt") as f:
    data = [line.rstrip().split(" ") for line in f.readlines()]

res = 0

for row in data:
    order = int(row[1]) - int(row[0])
    safe = True
    for i in range(1, len(row)):
        diff = int(row[i]) - int(row[i-1])
        if diff * order < 0 or abs(diff) < 1 or abs(diff) > 3:
            safe = False
            break

    if safe:
        res += 1

print(res)
