import pickle
import numpy

filepath = './data/ava_mock/annotations/ava_dense_proposals_train.FAIR.recall_93.9.pkl'
filepath = './data/ava/annotations/ava_dense_proposals_train.FAIR.recall_93.9.pkl'
with open(filepath, 'rb') as fp:
    d = pickle.load(fp)

filtered_keys = [key for key in d.keys() if 'gjasEUDkbuc' in key]
#filtered_keys = [key for key in d.keys()]
for z in filtered_keys:
    print (z)
    #tmp = z.split(',')
    #s = tmp[1]
    #if len(s) != 4:
    #    print (len(s))
    #if len(s) < 3:
    #    print ( s )
    #if len(d[z]) > 1:
    #    print(z, d[z])

quit()



unique_keys = set()

for key in d.keys():
    # Split the key at the comma and take the part before the comma
    prefix = key.split(',')[0]
    unique_keys.add(prefix)

# Print the unique keys
print(unique_keys)



# Step 1: Extract the frame_number part
frame_numbers = [int(key.split(',')[1]) for key in d.keys() if 'zlVkeKC6Ha8' in key]

# Step 2: Sort the frame numbers
frame_numbers.sort()

# Step 3: Identify gaps
gaps = []
for i in range(1, len(frame_numbers)):
    if frame_numbers[i] != frame_numbers[i-1] + 1:
        # If the difference between consecutive numbers is not 1, there's a gap
        gaps.append((frame_numbers[i-1], frame_numbers[i]))

# Step 4: Print the gaps
if gaps:
    print("Gaps found between frame numbers:")
    for gap in gaps:
        print(f"Gap between {gap[0]} and {gap[1]}")
else:
    print("No gaps found. Frame numbers are consecutive.")




