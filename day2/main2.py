with open("input.txt") as f:
    data = [list(map(lambda s: int(s), line.rstrip().split(" "))) for line in f.readlines()]

res = 0


def check_safeness(report):
    order = report[1] - report[0]
    for i in range(1, len(report)):
        cur_order = report[i] - report[i-1]
        diff = abs(cur_order)
        if order * cur_order < 0 or diff < 1 or diff > 3:
            return False
    return True


for row in data:
    if check_safeness(row):
        res += 1
    else:
        for i in range(len(row)):
            if check_safeness(row[:i] + row[i+1:]):
                res += 1
                break


print(res)
