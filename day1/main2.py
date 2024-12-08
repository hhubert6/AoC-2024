from collections import Counter


with open("input.txt") as f:
    data = [line[:-1].split("   ") for line in f.readlines()]

cnt = Counter([int(x) for _, x in data])

res = 0

for x, _ in data:
    x = int(x)
    res += x * cnt[x]

print(res)
