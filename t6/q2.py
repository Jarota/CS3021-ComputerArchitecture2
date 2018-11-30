import math
import sys

input = ["0000", "0004", "000c", "2200", "00d0", "00e0",
		"1130", "0028", "113c", "2204", "0010", "0020",
		"0004", "0040", "2208", "0008", "00a0", "0004",
		"1104", "0028", "000c", "0084", "000c", "3390",
		"00b0", "1100",	"0028", "0064", "0070", "00d0",
		"0008", "3394"]


class Tag:
	def __init__(self):
		self.value = -1
		self.timestamp = 0

class Set:
	def __init__(self, K):
		self.K = K
		self.timestamp = 0
		self.tags = []
		for i in range(K):
			self.tags.append(Tag())

	def check(self, tagval):
		self.timestamp += 1
		for tag in self.tags:
			if tag.value is tagval:
				tag.timestamp = self.timestamp
				return True # cache hit

		#cahce miss: lru replacement policy
		tagindex = 0
		time = sys.maxsize
		for i, tag in enumerate(self.tags):
			if tag.timestamp < time:
				time = tag.timestamp
				tagindex = i

		self.tags[i].value = tagval
		self.tags[i].timestamp = self.timestamp
		return False

class Cache:
	def __init__(self, L, N, K):
		self.L = L
		self.N = N
		self.K = K
		self.sets = []
		for i in range(N):
			self.sets.append(Set(K))

	def check(self, addressString):
		address = int(addressString, 16)
		setno = (address >> 4) & ((1 << int(math.log(self.N, 2))) - 1)
		tagval = address >> (int(math.log(self.N, 2)) + 4)
		return self.sets[setno].check(tagval)

caches = []
caches.append(Cache(16, 8, 1))
caches.append(Cache(16, 4, 2))
caches.append(Cache(16, 2, 4))
caches.append(Cache(16, 1, 8))

for cache in caches:
	hits = 0
	for s in input:
		if cache.check(s):
			#print("Hit  {}".format(s))
			hits += 1
		#else:
			#print("Miss {}".format(s))
	print("L: {}, N: {}, K: {}, Hits: {}".format(cache.L, cache.N, cache.K, hits))
