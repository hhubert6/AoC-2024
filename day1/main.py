from heapq import heapify, heappop

with open("input.txt") as f:
    data = [line[:-1].split("   ") for line in f.readlines()]

left_heap = []
right_heap = []

for left, right in data:
    left_heap.append(left)
    right_heap.append(right)


heapify(left_heap)
heapify(right_heap)

res = 0

for _ in range(len(data)):
    l = heappop(left_heap)
    r = heappop(right_heap)
    res += abs(int(l) - int(r))

print(res)
